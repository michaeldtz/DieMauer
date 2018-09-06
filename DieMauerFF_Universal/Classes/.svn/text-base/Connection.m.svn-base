	//
	//  SXURLLoader.m
	//  StaxIPhone
	//
	//  Created by Michael Dietz on 16.12.09.
	//  Copyright 2009 __MyCompanyName__. All rights reserved.
	//

#import "Connection.h"

@implementation Connection

#pragma mark Synchronous Call Get

-(NSData*) callURLSync:(NSString*)url{
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];  
	[request setURL:[NSURL URLWithString:url]];  
    [request setHTTPMethod:@"GET"];  
	
	NSLog(@"Loading URL %@",url);
	
	NSURLResponse *response = [[NSURLResponse alloc] init];
	NSError *error = nil;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	if(error == nil){
		return responseData; 
	} else {
		NSLog(@"Connection failed! Error - %@", [error localizedDescription]);		 	
	}
	return nil;		
}


#pragma mark Asynchronous Call GET

-(void)callURLAsync:(NSString*)url:(id)_delegate{
	
	delegate = _delegate;
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];  
	[request setURL:[NSURL URLWithString:url]];  
	[request setHTTPMethod:@"GET"];  
	
	NSLog(@"Loading URL %@",url);
	
	NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (connection) {
		receivedData=[[NSMutableData data] retain];
	} else {
		[delegate dataLoadingError:@"Error during connection initialization"];
	}
}

#pragma mark ConnectionDelegateMethods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];
}


#pragma mark Finalizing Delegate Methods

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
	NSString* errorText = [[NSString alloc] initWithFormat:@"Connection failed - %@",
						   [error localizedDescription]];
	
	[delegate dataLoadingError:errorText];
	
	[errorText release];
	[connection release]  , connection = nil;
	[receivedData release], receivedData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString* data = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
	[delegate dataLoadingSuccessful:data];
	[data autorelease];
	
	[connection release]  , connection = nil;
	[receivedData release], receivedData = nil;
}

-(void)dealloc{
	[receivedData release], receivedData = nil;
	delegate = nil;
	[super dealloc];
}

@end
