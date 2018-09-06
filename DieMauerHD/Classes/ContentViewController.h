//
//  ContentView.h
//  DieMauer
//
//  Created by Dietz, Michael on 9/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"
#import "ImageLoaderAndCacher.h"
#import "MapLocation.h"

@protocol ContentViewCloser

-(void)closeContentView;

@end

@interface ContentViewController : UIViewController <ImageLoaderDelegate, UIScrollViewDelegate> {

	IBOutlet UINavigationBar* mainToolbar;
	id<ContentViewCloser> delegate;
	MapLocation* __weak location;
	
	IBOutlet  UITextView* __weak textView;
	IBOutlet  UIImageView* __weak imageView;
	IBOutlet  UIScrollView* __weak scrollView;
	
	IBOutlet  UILabel*    __weak author;
	IBOutlet  UILabel*    __weak copyright;
	IBOutlet  UILabel*    __weak clickForInfo;
}

@property(nonatomic,strong) IBOutlet UINavigationBar* mainToolbar;
@property(weak) 	MapLocation* location;
@property(weak) 	IBOutlet  UITextView*   textView;
@property(weak)   IBOutlet  UIImageView*  imageView;
@property(weak)   IBOutlet  UIScrollView* scrollView;
@property(weak)   IBOutlet  UILabel*      author;
@property(weak)   IBOutlet  UILabel*      copyright;
@property(weak)   IBOutlet  UILabel*      clickForInfo;

-(id)initWithMapLocation:(MapLocation*)_location andDelegate:(id<ContentViewCloser>)_delegate;

-(IBAction)close;
-(IBAction)jumpToLicenseURL;

@end
