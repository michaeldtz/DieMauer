	//
	//  XMLFileLoader.m
	//  MapGameiPhone
	//
	//  Created by Dietz, Michael on 7/10/10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "MapDataLoader.h"
#import "MapLocation.h"


@implementation MapDataLoader

#pragma mark Load Overlays or Annotations

+(NSMutableArray*)loadOverlay:(NSString*)filename :(NSString*)code{
	MapDataLoader* loader = [[MapDataLoader alloc] init];
	NSArray* mapPoints = [loader createMapData:filename];
	
	
	NSMutableArray* polylineArray = [[NSMutableArray alloc] initWithCapacity:0]; 
	int objCount = [mapPoints count];
	CLLocationCoordinate2D pnts[objCount];
	int counter = 0;
	
	for(int i = 0; i < [mapPoints count]; i++){
		MapPoint* pnt = mapPoints[i];
		if(pnt.type < 3){
			if(pnt.type == 1 && i != 0){
				MKPolyline* polyLine = [MKPolyline polylineWithCoordinates:pnts count:counter];
				polyLine.title = code;
				[polylineArray addObject:polyLine];
				counter = 0;
			}  
			
			CLLocationCoordinate2D coordinate;
			coordinate.latitude = pnt.latitude;
			coordinate.longitude = pnt.longitude;
			pnts[counter] = coordinate;
			counter++;
			
			if(pnt.type == 2){
				MKPolyline* polyLine = [MKPolyline polylineWithCoordinates:pnts count:counter];
				polyLine.title = code;
				[polylineArray addObject:polyLine];
				counter = 0;
			}
		}
	}
	
	mapPoints = nil;
	return polylineArray;
}

+(NSMutableArray*)loadAnnotations :(NSString*)filename :(NSString*)code{
	MapDataLoader* loader = [[MapDataLoader alloc] init];
	
	NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0]; 
	NSArray* mapPoints = [loader createMapData:filename];
	
	
	for(int i = 0; i < [mapPoints count]; i++){
		MapPoint* pnt = mapPoints[i];
		if(pnt.type == 3){
			MapLocation* annotation = [[MapLocation alloc] init];
			CLLocationCoordinate2D coordinate;
            
			coordinate.latitude        = pnt.latitude;
			coordinate.longitude       = pnt.longitude;
			annotation.coord           = coordinate;
			annotation.poiType         = code;
			annotation.title           = pnt.title;
			annotation.subtitle        = pnt.subtitle;
			annotation.content         = pnt.content;
			annotation.webcontent      = pnt.webcontent;
			annotation.imageUrl        = pnt.imageurl;
			annotation.imageAuthor     = pnt.imageAuthor;
			annotation.imageLicenseURL = pnt.imageLicenseURL;
			annotation.zoomType        = pnt.zoomType;
			annotation.imageCRType     = pnt.imageCRType;
			[array addObject:annotation];
		}
	}
	mapPoints = nil;
	return array;
}

#pragma mark XML Parsing

-(NSArray*)createMapData:(NSString*)filename{
	
	NSLog(@"LoadMapData: %@", filename);
	
		//1. Step Try to use file from download directory (actually documents)
	NSArray*  paths     = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path1     = paths[0];
	NSString* fullPath1 = [path1 stringByAppendingPathComponent:filename];
	NSData*   data1      = [NSData dataWithContentsOfFile:fullPath1];
		//NSLog(@"Step 1: %@", fullPath1);
	
	if(data1 != nil){
			//Parse the loaded XML data
		points   = [[NSMutableArray alloc] init];
		NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data1];
		[parser setDelegate:self];
		if(![parser parse]){
			NSLog(@"Error Loading Local XML-File: %@", [parser parserError]);
			textInProgress = nil;
			parser = nil;
			points = nil;
		} else {
			NSLog(@"Loaded cached file %d", [points count]);
			textInProgress = nil;
			parser = nil;
			return points;
		}
	}
	
		//2. Step Try to load file from app bundle (delievered with app)
	NSString* path2     = [[NSBundle mainBundle] bundlePath];
	NSString* fullPath2 = [path2 stringByAppendingPathComponent:filename];
	NSData*   data2     = [NSData dataWithContentsOfFile:fullPath2];
	NSLog(@"No cached file available, loading defaults");
	
		//Parse the loaded XML data
	points   = [[NSMutableArray alloc] init];
	NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data2];
	[parser setDelegate:self];
	if(![parser parse]){
		NSLog(@"Error Loading Data 2: %@", [parser parserError]);
		parser = nil;
		points = nil;
		textInProgress = nil;
	}
	textInProgress = nil;
	parser = nil;
	return points;
}

#pragma mark XML Delegate calls

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
	elementName = [elementName uppercaseString];
	
		//NSLog(@"XML Element Start: %@", elementName);
	
	if(inContent == NO){
		
		attributes = attributeDict;
		attributesForElement = elementName;
		
		[textInProgress setString:@""];
		
		if([[elementName uppercaseString] isEqualToString:@"POINT"]){
			point = [[MapPoint alloc] init];
			elementsOccured = [[NSMutableArray alloc] initWithCapacity:3];
		}else if([[elementName uppercaseString] isEqualToString:@"WEBCONTENT"]){
			inContent = YES;
		} else if([[elementName uppercaseString] isEqualToString:@"IMAGE"]){
			NSString* zoomType = attributeDict[@"zoomtype"];
			if(zoomType != nil)
				point.zoomType = [zoomType intValue];
		}
	} else {
		[textInProgress appendFormat:@"<%@>", elementName];
	}
	
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
	elementName = [elementName uppercaseString];
	
		//NSLog(@"XML Element End: %@", elementName);
	
	if(inContent == NO || [[elementName uppercaseString] isEqualToString:@"WEBCONTENT"]){ 
		
			//Keep element names and check if they reoccur
		if([elementsOccured containsObject:elementName]){
			NSString* contentLangCode = [attributes[@"language"] uppercaseString];
			NSArray* preferredLangs = [NSLocale preferredLanguages];
			NSString* usersLangCode   = [preferredLangs[0] uppercaseString];	
			if(![attributesForElement isEqualToString:elementName] || contentLangCode == nil || ![contentLangCode isEqualToString:usersLangCode]){
					//NSLog(@"Localized %@ for %@, users locale is %@", elementName, contentLangCode, usersLangCode);
				return;
			}
		} else {
			[elementsOccured addObject:elementName];
		}
		
		if([[elementName uppercaseString] isEqualToString:@"POINT"]){
			[points addObject:point];
			point = nil;
			elementsOccured = nil;
		}else if([[elementName uppercaseString] isEqualToString:@"LONGITUDE"]){
			point.longitude = [textInProgress floatValue];
		}else if([[elementName uppercaseString] isEqualToString:@"LATITUDE"]){
			point.latitude = [textInProgress floatValue];
		}else if([[elementName uppercaseString] isEqualToString:@"TITLE"]){
			point.title = textInProgress;
		}else if([[elementName uppercaseString] isEqualToString:@"SUBTITLE"]){
			point.subtitle = textInProgress;
		}else if([[elementName uppercaseString] isEqualToString:@"TYPE"]){
			point.type = [textInProgress intValue];
		}else if([[elementName uppercaseString] isEqualToString:@"CONTENT"]){
			point.content = [textInProgress copy];
		}else if([[elementName uppercaseString] isEqualToString:@"IMAGE"]){
			point.imageurl = [textInProgress copy];
		}else if([[elementName uppercaseString] isEqualToString:@"IMAGECR"]){
			point.imageAuthor = [textInProgress copy];
		}else if([[elementName uppercaseString] isEqualToString:@"IMAGECRTYPE"]){
			point.imageCRType = [textInProgress copy];
		}else if([[elementName uppercaseString] isEqualToString:@"IMAGECRURL"]){
			point.imageLicenseURL = [textInProgress copy];
		}else if([[elementName uppercaseString] isEqualToString:@"WEBCONTENT"]){
			NSString* content = [textInProgress copy];		
			content = [NSString stringWithFormat:@"<html><body>%@</body></html>", content];
			NSLog(@"Content: %@", content);
			point.webcontent = content;
			inContent = NO;
		}
		
		[textInProgress setString:@""];
	} else {
		[textInProgress appendFormat:@"</%@>", elementName];
	}
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
	if(textInProgress == nil)
		textInProgress = [[NSMutableString alloc] init];
    [textInProgress appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
	NSLog(@"Error during XML parsing: %@", parseError);
}


@end
