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
	MapLocation* location;
	
	IBOutlet  UITextView* textView;
	IBOutlet  UIImageView* imageView;
	IBOutlet  UIScrollView* scrollView;
	
	IBOutlet  UILabel*    author;
	IBOutlet  UILabel*    copyright;
	IBOutlet  UILabel*    clickForInfo;
}

@property(nonatomic,retain) IBOutlet UINavigationBar* mainToolbar;
@property(assign) 	MapLocation* location;
@property(assign) 	IBOutlet  UITextView*   textView;
@property(assign)   IBOutlet  UIImageView*  imageView;
@property(assign)   IBOutlet  UIScrollView* scrollView;
@property(assign)   IBOutlet  UILabel*      author;
@property(assign)   IBOutlet  UILabel*      copyright;
@property(assign)   IBOutlet  UILabel*      clickForInfo;

-(id)initWithMapLocation:(MapLocation*)_location andDelegate:(id<ContentViewCloser>)_delegate;

-(IBAction)close;
-(IBAction)jumpToLicenseURL;

@end
