//
//  DieMauerHDAppDelegate.h
//  DieMauerHD
//
//  Created by Michael Dietz on 11.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@class MainViewController;

@interface DieMauerHDAppDelegate : NSObject <UIApplicationDelegate>{
    
    MainViewController *viewController;
}

@property (nonatomic, strong) IBOutlet MainViewController *viewController;
@property (nonatomic, strong) IBOutlet UIWindow *window;

@end
