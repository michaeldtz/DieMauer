//
//  SXURLLoader.h
//  StaxIPhone
//
//  Created by Michael Dietz on 16.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CFNetwork/CFHTTPStream.h>


@protocol FileLoaderDelegate

-(void)     fileLoadingFinished:(BOOL)success:(NSString*)message;


@end

@interface FileLoader : NSObject {

	NSMutableData* receivedData; 
	
	id<FileLoaderDelegate> delegate;       
	NSString* path;
	
}

-(void)    loadFileAsync:(NSString*)url:(id)_delegate:(NSString*)path;


@end
