//
//  ImageLoaderAndCacher.h
//  DieMauer
//
//  Created by Dietz, Michael on 9/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageLoaderDelegate

-(void)     imageLoaded:(UIImage*)image;
-(void)     imageLoadingFailed:(NSString*)error;

@end


@interface ImageLoaderAndCacher : NSObject {

	NSMutableData*          receivedData; 
    id<ImageLoaderDelegate> _delegate;
	NSString*               fullPath; 
	
}

-(void)    loadImage:(NSString*)filename:(id<ImageLoaderDelegate>)delegate;

@end
