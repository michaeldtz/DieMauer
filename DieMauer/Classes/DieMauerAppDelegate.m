	//
	//  MapGameiPhoneAppDelegate.m
	//  MapGameiPhone
	//
	//  Created by Michael Dietz on 07.07.10.
	//  Copyright __MyCompanyName__ 2010. All rights reserved.
	//

#import "DieMauerAppDelegate.h"
#import "MainViewController.h"

@implementation DieMauerAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    	
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	if([[SettingsAccess getInstance] autoCheckUpd])
		[viewController startMapUpdate];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	
}


- (void)dealloc {
	[viewController release];
	[window release];
	[super dealloc];
}


@end

