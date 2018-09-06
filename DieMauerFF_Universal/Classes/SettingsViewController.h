//
//  SettingsView.h
//  DieMauer
//
//  Created by Dietz, Michael on 10/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface SettingsViewController : UIViewController {
	
	IBOutlet UINavigationBar* mainToolbar;
	id<ContentViewCloser> delegate;
	IBOutlet UISwitch* switchView;
	IBOutlet UILabel* contentVersionLabel;
}

@property(nonatomic,retain) IBOutlet UINavigationBar* mainToolbar;
@property(nonatomic,retain) IBOutlet UISwitch* switchView;
@property(nonatomic,retain) IBOutlet UILabel* contentVersionLabel;

-(id)initWithDelegate:(id<ContentViewCloser>)_delegate;
-(IBAction)close;
-(IBAction)switchValueChanged;
-(IBAction)updateNow;

@end
