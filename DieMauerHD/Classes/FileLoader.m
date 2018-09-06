	//
	//  SXURLLoader.m
	//  StaxIPhone
	//
	//  Created by Michael Dietz on 16.12.09.
	//  Copyright 2009 __MyCompanyName__. All rights reserved.
	//

#import "FileLoader.h"

@implementation FileLoader


-(void)    loadFileAsync:(NSString*)url :(id<FileLoaderDelegate>)_delegate :(NSString*)_path{
	delegate = _delegate;
	path     = [_path copy];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];  
	[request setURL:[NSURL URLWithString:url]];  
	[request setHTTPMethod:@"GET"];  
	
	NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (connection) {
		receivedData=[NSMutableData data];
	} else {
		[delegate fileLoadingFinished:NO:@"Error during connection init"];
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
	
	[delegate fileLoadingFinished:NO:errorText];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSLog(@"Load Finish %@", path);
	[receivedData writeToFile:path atomically:YES];
	[delegate fileLoadingFinished:YES :@""];
}

@end
