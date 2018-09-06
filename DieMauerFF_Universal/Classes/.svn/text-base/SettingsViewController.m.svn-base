	//
	//  SettingsView.m
	//  DieMauer
	//
	//  Created by Dietz, Michael on 10/1/10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "SettingsViewController.h"


@implementation SettingsViewController

@synthesize mainToolbar, switchView, contentVersionLabel;

-(id)initWithDelegate:(id<ContentViewCloser>)_delegate{
    if ((self = [super initWithNibName:@"SettingsView" bundle:nil])) {
		delegate = _delegate;
    }
    return self;
	
}

-(void)viewDidLoad{	
	[mainToolbar.topItem setTitle:NSLocalizedString(@"TITLE", @"")];
	SettingsAccess* settings = [SettingsAccess getInstance];
	switchView.on = settings.autoCheckUpd;
	
	contentVersionLabel.text = [NSString stringWithFormat:@"%d", settings.mapDataVersion];
}


-(IBAction)close{
	[delegate closeContentView];
}

-(IBAction)switchValueChanged{
	SettingsAccess* settings = [SettingsAccess getInstance];
	settings.autoCheckUpd = switchView.on;
	[SettingsAccess saveSettings];
}

-(IBAction)updateNow{
	MainViewController* mainView = (MainViewController*)delegate;
	[mainView startMapUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


@end
