	//
	//  MapDataUpdate.m
	//  DieMauer
	//
	//  Created by Dietz, Michael on 9/4/10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "MapDataUpdatLoader.h"
#import "Connection.h"
#import "SettingsAccess.h"


@implementation MapDataUpdatLoader

#pragma mark External Map Data Loading

-(void)loadExternalMapWithFilename:(NSString*)filename{
	FileLoader* fileLoader = [[FileLoader alloc] init];
	NSArray*  paths     = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path      = [paths objectAtIndex:0];
	NSString* fullPath  = [path stringByAppendingPathComponent:filename];
	NSString* baseURL   = NSLocalizedString(@"http://www.homelessapps.de/diemauer/", @"");
	NSString* url = [NSString stringWithFormat:@"%@%@", baseURL, filename];
	
	[fileLoader loadFileAsync:url :self :fullPath];
}


-(void)loadExternalMaps:(id<NewDataArrivalDelegate>) delegate{
	_delegate = delegate;
	
		//Check 
	NSLog(@"Check for MapData Update");
	NSString* baseURL   = NSLocalizedString(@"http://www.homelessapps.de/diemauer/", @"");
	NSString* url = [NSString stringWithFormat:@"%@%@", baseURL, @"mapdataversion"];
	
	connection = [[Connection alloc] init];
	[connection callURLAsync:url:self];	
}

#pragma mark Delegate of Connection

-(void)     dataLoadingSuccessful:(NSString*)resultString{
	NSLog(@"Map Version received");
	if(resultString != nil){
		SettingsAccess* settings = [SettingsAccess getInstance];
		newestVersion = [resultString intValue];
		
		int localVersion = settings.mapDataVersion;
		
		NSLog(@"Version on iPhone is %d , newest Version is %d", localVersion, newestVersion);
		
		if(newestVersion > localVersion){
			NSLog(@"Start Loading Map Update");
			[self loadExternalMapWithFilename:NSLocalizedString(@"original.xml",@"")];
			[self loadExternalMapWithFilename:NSLocalizedString(@"today.xml",@"")];
			[self loadExternalMapWithFilename:NSLocalizedString(@"borders.xml",@"")];
			[self loadExternalMapWithFilename:NSLocalizedString(@"pois.xml",@"")];	
			[connection release], connection = nil;
			return;
		}
	}
	
	[connection release], connection = nil;
	[_delegate noNewMapDataArrived];
	
}
-(void)     dataLoadingError:(NSString*) errorText{
	NSLog(@"Error Checking for Map Update %@", errorText);
	[connection release], connection = nil;
	[_delegate noNewMapDataArrived];
}

#pragma mark Delegate of FileLoader

-(void) fileLoadingFinished:(BOOL)success:(NSString*)message{
	if(success)
		successfulLoading = YES;
	fileloadings++;
	
	if(fileloadings >= 4){
		if(successfulLoading == YES){
			NSLog(@"MapData Loading Finished");
			SettingsAccess* settings = [SettingsAccess getInstance];
			settings.mapDataVersion = newestVersion;
			[SettingsAccess saveSettings];
			[_delegate newMapDataArrived];
		} else{
			[_delegate noNewMapDataArrived];
		}
	}
}

-(void)dealloc{
	[connection release], connection = nil;
	[super dealloc];
}

@end
