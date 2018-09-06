//
//  SXURLLoader.h
//  StaxIPhone
//
//  Created by Michael Dietz on 16.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CFNetwork/CFHTTPStream.h>

@protocol ConnectionFeedback

-(void)     dataLoadingSuccessful:(NSString*)resultString;
-(void)     dataLoadingError:(NSString*) errorText;

@end

@interface Connection : NSObject {

	NSMutableData* receivedData; 
	id<ConnectionFeedback> delegate;                 
	
}

	//Syncronous Calls
-(NSData*)callURLSync:(NSString*)url;

	//Asyncronous Calls
-(void)   callURLAsync:(NSString*)url :(id)_delegate;


@end
