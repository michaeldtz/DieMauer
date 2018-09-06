//
//  ImageLoaderAndCacher.m
//  DieMauer
//
//  Created by Dietz, Michael on 9/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageLoaderAndCacher.h"


@implementation ImageLoaderAndCacher

-(void)    loadImage:(NSString*)filename:(id<ImageLoaderDelegate>)delegate{
	NSLog(@"Loading Image locally");
	
	_delegate = delegate;

	/*
	 1.) Check if the image is in the delievered content
	 */	
	NSString*  path1     = [[NSBundle mainBundle] bundlePath];
	fullPath             = [[path1 stringByAppendingPathComponent:filename] copy];
	NSData*   data1       = [NSData dataWithContentsOfFile:fullPath];
	
	if(data1 != nil){
		UIImage* image1 = [[UIImage alloc] initWithData:data1];
		if(image1 != nil){
			[_delegate imageLoaded:image1];
			return;
		}
	}
	
	/*
	 2.) Check if the image had already been loaded and is now available
	 */	
	NSArray*  paths     = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path      = [paths objectAtIndex:0];
	fullPath            = [[path stringByAppendingPathComponent:filename] copy];
	NSData*   data      = [NSData dataWithContentsOfFile:fullPath];
	
	if(data != nil){
		UIImage* image = [[UIImage alloc] initWithData:data];
		if(image != nil){
			[_delegate imageLoaded:image];
			return;
		}
	}
	
	/*
	 3.) If the image had not been created successfully then load it
	*/
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];  
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.homelessapps.de/diemauer/%@",filename]]];  
	[request setHTTPMethod:@"GET"];  

		NSLog(@"Loading Image remote %@", [NSString stringWithFormat:@"http://www.homelessapps.de/diemauer/%@",filename]);
	
	NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (connection) {
		receivedData=[[NSMutableData data] retain];
	} else {
		[_delegate imageLoadingFailed:@"Error during connection initialization"];
	}
	
}


#pragma mark ConnectionDelegateMethods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Load Failed");
	NSString* errorText = [[NSString alloc] initWithFormat:@"Load Failed! Error - %@",
						   [error localizedDescription]];
	
	[_delegate imageLoadingFailed:errorText];
	[connection release];
	[receivedData release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[receivedData writeToFile:fullPath atomically:YES];
	UIImage* image = [[UIImage alloc] initWithData:receivedData];
	[_delegate imageLoaded:image];
	[connection release];
}

@end
