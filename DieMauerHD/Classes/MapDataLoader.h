//
//  XMLFileLoader.h
//  MapGameiPhone
//
//  Created by Dietz, Michael on 7/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MapPoint.h"


@class MainViewController;




@class GameMap;

@interface MapDataLoader : NSObject <NSXMLParserDelegate> {

	NSMutableArray*  points;
	MapPoint*        point;
    NSMutableString* textInProgress;
	NSString*        _filename;
	BOOL             inContent;
	NSMutableArray*  elementsOccured;
	NSDictionary*    attributes;
	NSString*        attributesForElement;
}


+(NSMutableArray*)loadOverlay :(NSString*)filename :(NSString*)code;
+(NSMutableArray*)loadAnnotations :(NSString*)filename :(NSString*)code;

-(NSArray*)createMapData:(NSString*)filename;

@end
