	//
	//  SettingsAccess.m
	//  DieMauer
	//
	//  Created by Dietz, Michael on 8/31/10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "SettingsAccess.h"


@implementation SettingsAccess

@synthesize poisShown, originalShown, bordersShown, todayShown, mapDataVersion, notFirstTime, autoCheckUpd;

static SettingsAccess* settings;

-(id)init{
	originalShown = YES;
	bordersShown  = YES;
	autoCheckUpd  = YES;
	return self;
}

+(SettingsAccess*)getInstance{
	if(settings == nil){
		NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
		NSData* data = (NSData*)[prefs objectForKey:@"SETTINGS"];
		if (data != nil)
			settings = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		if(settings == nil)
			settings = [[SettingsAccess alloc] init];
	}
	return settings;
}

+(void)saveSettings{
	NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
	NSData* data = [NSKeyedArchiver archivedDataWithRootObject:settings];
	[prefs setObject:data forKey:@"SETTINGS"];
	[prefs synchronize];	
}

-(id)initWithCoder:(NSCoder *)aDecoder{
	poisShown      = [aDecoder decodeBoolForKey:@"POIS"];
	originalShown  = [aDecoder decodeBoolForKey:@"ORIGINAL"];
	bordersShown   = [aDecoder decodeBoolForKey:@"BORDERS"];
	todayShown     = [aDecoder decodeBoolForKey:@"TODAY"];
	notFirstTime   = [aDecoder decodeBoolForKey:@"NOTFIRSTTIME"];
	mapDataVersion = [aDecoder decodeIntForKey:@"MAPDATAVERSION"];
	autoCheckUpd   = [aDecoder decodeBoolForKey:@"AUTOCHECKUPDATES"]; 
	return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
	[aCoder encodeBool:poisShown forKey:@"POIS"];
	[aCoder encodeBool:originalShown forKey:@"ORIGINAL"];
	[aCoder encodeBool:bordersShown forKey:@"BORDERS"];
	[aCoder encodeBool:todayShown forKey:@"TODAY"];
	[aCoder encodeBool:notFirstTime forKey:@"NOTFIRSTTIME"];
	[aCoder encodeInt:mapDataVersion forKey:@"MAPDATAVERSION"];
	[aCoder encodeBool:autoCheckUpd forKey:@"AUTOCHECKUPDATES"];
}

@end
