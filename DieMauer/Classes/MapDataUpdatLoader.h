//
//  MapDataUpdate.h
//  DieMauer
//
//  Created by Dietz, Michael on 9/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileLoader.h"

@class Connection;

@protocol NewDataArrivalDelegate

@required
-(void)newMapDataArrived;
-(void)noNewMapDataArrived;

@end

@interface MapDataUpdatLoader : NSObject <FileLoaderDelegate> {

	Connection* connection;
	id<NewDataArrivalDelegate> _delegate;
	BOOL successfulLoading;
	int  fileloadings;
	int  newestVersion;
}

-(void)loadExternalMaps:(id<NewDataArrivalDelegate>) delegate;

@end
