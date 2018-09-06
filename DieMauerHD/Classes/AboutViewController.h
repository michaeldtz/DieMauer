//
//  AboutView.h
//  DieMauer
//
//  Created by Dietz, Michael on 9/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import <MessageUI/MessageUI.h>

@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate> {

	IBOutlet UINavigationBar* mainToolbar;
	id<ContentViewCloser> delegate;
	IBOutlet UITextView* textView;
}

@property(nonatomic,strong) IBOutlet UINavigationBar* mainToolbar;
@property(nonatomic,strong) IBOutlet UITextView* textView;

-(id)initWithDelegate:(id<ContentViewCloser>)_delegate;
-(IBAction)close;
-(IBAction)openFeedbackForm;

@end

