//
//  SettingsAccess.h
//  DieMauer
//
//  Created by Dietz, Michael on 8/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SettingsAccess : NSObject <NSCoding> {

	BOOL            poisShown;
	BOOL            originalShown;
	BOOL            bordersShown;
	BOOL            todayShown;
	BOOL            autoCheckUpd;
	int             mapDataVersion;
	BOOL            notFirstTime;
	
}

@property(assign) 	BOOL            poisShown;
@property(assign) 	BOOL            originalShown;
@property(assign) 	BOOL            bordersShown;
@property(assign) 	BOOL            todayShown;
@property(assign) 	BOOL            notFirstTime;
@property(assign) 	BOOL            autoCheckUpd;
@property(assign) 	int             mapDataVersion;

+(SettingsAccess*)getInstance;
+(void)saveSettings;

@end
