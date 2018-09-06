	//
	//  ContentView.m
	//  DieMauer
	//
	//  Created by Dietz, Michael on 9/7/10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "ContentViewController.h"

@implementation ContentViewController

@synthesize mainToolbar, location, textView, imageView, scrollView, author, copyright, clickForInfo;

-(id)initWithMapLocation:(MapLocation*)_location andDelegate:(id<ContentViewCloser>)_delegate{
    if ((self = [super initWithNibName:@"ContentView" bundle:nil])) {
		location = _location;
		delegate = _delegate;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[mainToolbar.topItem setTitle:location.title];
	
		//The Main Content
	textView.text  = location.content;

		//The image
	if(location.imageUrl != nil){
		ImageLoaderAndCacher* imageLoader = [[ImageLoaderAndCacher alloc] init];
		[imageLoader loadImage:location.imageUrl :self];
	} else {
		NSString* path     = [[NSBundle mainBundle] bundlePath];
		NSString* fullPath = [path stringByAppendingPathComponent:@"defaultimage.jpg"];
		NSData*   data     = [NSData dataWithContentsOfFile:fullPath];
		UIImage* image     = [[UIImage alloc] initWithData:data];
		[self imageLoaded:image];
		
		location.imageCRType = @"Creative Commons";
		location.imageAuthor = @"Wici";
	}
	
		//The image copyright
	if(location.imageCRType != nil && ![location.imageCRType isEqualToString:@"" ])
		copyright.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"IMAGE_CR",@"COPYRIGHT"), location.imageCRType];
	
		//The image author
	if(location.imageAuthor != nil && ![location.imageAuthor isEqualToString:@"" ])
		author.text    = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"IMAGE_AUTHOR",@"COPYRIGHT"), location.imageAuthor];

	if(location.imageUrl != nil && ![location.imageUrl isEqualToString:@"" ])
		clickForInfo.text = NSLocalizedString(@"CLICK_INFO", @"");
	
}

#pragma mark UI Actions

-(IBAction)close{
	[delegate closeContentView];
}

-(IBAction)jumpToLicenseURL{
	NSLog(@"License URL %@", location.imageLicenseURL);
	if(![location.imageLicenseURL isEqualToString:@""]){
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:location.imageLicenseURL ]];
	}
}

#pragma mark ImageLoaderDelegate

-(void)     imageLoaded:(UIImage*)image{
	[self.imageView setImage:image];
	CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
	
	self.imageView.frame = rect;
	self.scrollView.contentSize = image.size;
	self.scrollView.minimumZoomScale = 0.5;	
	self.scrollView.maximumZoomScale = 2;
	
	double xScale = self.scrollView.frame.size.width / image.size.width;
	double yScale = self.scrollView.frame.size.height / image.size.height;
	
	if(xScale < yScale){
		self.scrollView.minimumZoomScale = xScale;
		if(location.zoomType == 1)
			self.scrollView.zoomScale        = xScale;
		else if(location.zoomType == 2)
			self.scrollView.zoomScale        = (yScale + xScale) / 2;
		else 
			self.scrollView.zoomScale        = yScale;
	}
	else{
		self.scrollView.minimumZoomScale = yScale;
		if(location.zoomType == 1)
			self.scrollView.zoomScale        = yScale;
		else if(location.zoomType == 2)
			self.scrollView.zoomScale        = (xScale + yScale) / 2;
		else 
			self.scrollView.zoomScale        = xScale;
	}
}

-(void)scrollViewDidZoom:(UIScrollView *)pScrollView {
	CGRect innerFrame = imageView.frame;
	CGRect scrollerBounds = pScrollView.bounds;
	
	if ( ( innerFrame.size.width < scrollerBounds.size.width ) || ( innerFrame.size.height < scrollerBounds.size.height ) )
	{
		CGFloat tempx = imageView.center.x - ( scrollerBounds.size.width / 2 );
		CGFloat tempy = imageView.center.y - ( scrollerBounds.size.height / 2 );
		CGPoint myScrollViewOffset = CGPointMake( tempx, tempy);
		
		pScrollView.contentOffset = myScrollViewOffset;
		
	}
	
	UIEdgeInsets anEdgeInset = { 0, 0, 0, 0};
	if ( scrollerBounds.size.width > innerFrame.size.width )
	{
		anEdgeInset.left = (scrollerBounds.size.width - innerFrame.size.width) / 2;
		anEdgeInset.right = -anEdgeInset.left;  // I don't know why this needs to be negative, but that's what works
	}
	if ( scrollerBounds.size.height > innerFrame.size.height )
	{
		anEdgeInset.top = (scrollerBounds.size.height - innerFrame.size.height) / 2;
		anEdgeInset.bottom = -anEdgeInset.top;  // I don't know why this needs to be negative, but that's what works
	}
	pScrollView.contentInset = anEdgeInset;
}


-(void)     imageLoadingFailed:(NSString*)error{
	NSLog(@"%@", error);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
	return imageView;
}

#pragma mark App Lifecycle Methods

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
