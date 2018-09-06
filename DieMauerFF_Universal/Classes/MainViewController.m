	//
	//  RootViewController.m
	//  MapGameiPhone
	//
	//  Created by Michael Dietz on 07.07.10.
	//  Copyright __MyCompanyName__ 2010. All rights reserved.
	//

#import "MainViewController.h"
#import "UIView+Mover.h"
#import "AboutViewController.h"
#import "SettingsViewController.h"

#define MOVE_SUBTOOLBARS_SMALL 40.0
#define MOVE_SUBTOOLBARS_FULLL 75.0

@implementation MainViewController

@synthesize map;
@synthesize mainToolbar, subToolbar, backGroundImage, poiButton, banner;

#pragma mark Initialization

-(void)viewDidLoad{
	settings = [SettingsAccess getInstance];
	
	int version = settings.mapDataVersion;
	
	if(version >= 15){
		poiButton.hidden = NO;
	}
	
		//Intialize
	[self initDefaultMapContent];
	[self initLocalizedViewStrings];
	[self focusOnBerlin];	
	
	if(settings.notFirstTime == NO){
		settings.notFirstTime = YES;
		[SettingsAccess saveSettings];
		supressUpdatePopup = YES;
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"WELCOME", @"") message:NSLocalizedString(@"WELCOME_LONG", @"") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"GO", @""),nil];
		[alert show];
		[alert release];
	}
	
	toolbarMove = MOVE_SUBTOOLBARS_SMALL;
	
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
		//NSLog(@"%f, %f, %f, %f", self.map.region.center.latitude, self.map.region.center.longitude, self.map.region.span.latitudeDelta, self.map.region.span.longitudeDelta);
}

-(void)initLocalizedViewStrings{
	UIButton* buttonOriginal = (UIButton*) [self.view viewWithTag:100];
	UIButton* buttonToday    = (UIButton*)[self.view viewWithTag:102];
	UIButton* buttonBorders  = (UIButton*)[self.view viewWithTag:101];
	UIButton* buttonPOIS     = (UIButton*)[self.view viewWithTag:103];
	
	[buttonOriginal setTitle:NSLocalizedString(@"BUT_ORIGINAL", @"") forState:UIControlStateNormal];
	[buttonToday    setTitle:NSLocalizedString(@"BUT_TODAY", @"") forState:UIControlStateNormal];
	[buttonBorders  setTitle:NSLocalizedString(@"BUT_BORDERS", @"") forState:UIControlStateNormal];
	[buttonPOIS     setTitle:NSLocalizedString(@"BUT_POIS", @"") forState:UIControlStateNormal];
	
	[mainToolbar.topItem setTitle:NSLocalizedString(@"TITLE", @"")];
}


-(void)initDefaultMapContent{
		//Show the by default selected map contents
	if(settings.originalShown){
		settings.originalShown = NO;
		[self addOriginal];
	}
	
	if(settings.todayShown){
		settings.todayShown = NO;
		[self addToday];
	}
	
	if(settings.bordersShown){
		settings.bordersShown = NO;
		[self addBorders];
	}
	
	if(settings.poisShown){
		settings.poisShown = NO;
		[self addPOIS];	
	}
	
	[self addApplicationLocationFlag];
}

#pragma mark Initialize the Map

-(IBAction)addOriginal{
	if(original == nil){
		original = [MapDataLoader loadOverlay:NSLocalizedString(@"original.xml",@""):@"ORIGINAL"];
	}
	if(!settings.originalShown)
		[self.map addOverlays:original];
	else 
		[self.map removeOverlays:original];
	settings.originalShown = !settings.originalShown;
	[SettingsAccess saveSettings];
}

-(IBAction)addBorders{
	if(borders == nil){
		borders = [MapDataLoader loadAnnotations:NSLocalizedString(@"borders.xml",@""):@"BORDER"];
	}
	if(!settings.bordersShown)
		[self.map addAnnotations:borders];
	else 
		[self.map removeAnnotations:borders];
	settings.bordersShown = !settings.bordersShown;
	[SettingsAccess saveSettings];
}

-(IBAction)addToday{
	if(today == nil){
		today = [MapDataLoader loadAnnotations:NSLocalizedString(@"today.xml", @""):@"TODAY"];
	}
	if(!settings.todayShown)
		[self.map addAnnotations:today];
	else 
		[self.map removeAnnotations:today];
	settings.todayShown = !settings.todayShown;
	[SettingsAccess saveSettings];
}

-(IBAction)addPOIS{
	if(pois == nil){
		pois = [MapDataLoader loadAnnotations:NSLocalizedString(@"pois.xml",@""):@"POI"];
	}
	if(!settings.poisShown)
		[self.map addAnnotations:pois];
	else 
		[self.map removeAnnotations:pois];
	settings.poisShown = !settings.poisShown;
	[SettingsAccess saveSettings];
}

-(IBAction)addApplicationLocationFlag{
	aboutLocation = [[SpecialAnnotation alloc] init];
	aboutLocation.latitude     = 52.575998;
	aboutLocation.longitude    = 13.453344;
	aboutLocation.imageName    = @"about.png";
	aboutLocation.type         = 1;
	aboutLocation.title        = NSLocalizedString(@"ABOUT",@"");
	aboutLocation.subtitle     = NSLocalizedString(@"ABOUT_SUBTITLE", @"");
	[self.map addAnnotation:aboutLocation];
	
	settingsLocation = [[SpecialAnnotation alloc] init];
	settingsLocation.imageName    = @"settings.png";
	settingsLocation.type         = 2;
	settingsLocation.title        = NSLocalizedString(@"SETTINGS",@"");
	settingsLocation.subtitle     = NSLocalizedString(@"SETTINGS_SUBTITLE", @"");
	
	if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
		settingsLocation.latitude     = 52.575998;
		settingsLocation.longitude    = 13.462554;
	} else {
		settingsLocation.latitude     = 52.550576;
		settingsLocation.longitude    = 13.322983;
	}
	
	[self.map addAnnotation:settingsLocation];
}




#pragma mark Receive when a new MapData Version arrives

-(void)startMapUpdate{
		//Start Updater
	mapUpdater = [[MapDataUpdatLoader alloc] init];
	[mapUpdater loadExternalMaps:self];
}

-(void)newMapDataArrived{
	
	[mapUpdater release],mapUpdater = nil;
	
		//Remove All
	[self.map removeOverlays:original];
	[self.map removeAnnotations:borders];
	[self.map removeAnnotations:today];
	[self.map removeAnnotations:pois];
	
		//Reset
	[original release];
	original = nil;
	[borders release];
	borders = nil;
	[today release];
	today = nil;
	[pois release];
	pois = nil;
	
		//Add Again
	if(settings.originalShown){
		settings.originalShown = !settings.originalShown;
		[self addOriginal];
	}
	if(settings.bordersShown){
		settings.bordersShown = !settings.bordersShown;
		[self addBorders];
	}
	if(settings.todayShown){
		settings.todayShown = !settings.todayShown;
		[self addToday];
	}
	if(settings.poisShown){
		settings.poisShown = !settings.poisShown;
		[self addPOIS];
	}
	
	if(!supressUpdatePopup){
			//Display an alert that the new version has been loaded
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NEW_VERSION", @"") message:NSLocalizedString(@"NEW_VERSION_LONG", @"") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", @""),nil];
		[alert show];
		[alert release];
	} else {
		supressUpdatePopup = NO;
	}
	
	int version = settings.mapDataVersion;
	
	if(version >= 15){
		poiButton.hidden = NO;
	}
}

-(void)noNewMapDataArrived{
	NSLog(@"noNewMapDataArrived");
	[mapUpdater release],mapUpdater = nil;
}

#pragma mark Content View 

-(void)openContentView:(MapLocation*)location{
	ContentViewController* controller = [[ContentViewController alloc]initWithMapLocation:location andDelegate:self];
	
	if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
		popOver = [[UIPopoverController alloc] initWithContentViewController:controller];
		popOver.popoverContentSize = controller.view.frame.size;
		
		[self.map deselectAnnotation:location animated:YES];
		
		CGPoint point = [self.map convertCoordinate:location.coord toPointToView:self.map];
		CGRect popOverRect = CGRectMake(point.x, point.y, 1, 30);
		
		[popOver presentPopoverFromRect:popOverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];	
	} else {
		[self presentModalViewController:controller animated:YES];
	}
}

-(void)openAboutView{
	AboutViewController* controller = [[AboutViewController alloc] initWithDelegate:self];
	
	if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
		popOver = [[UIPopoverController alloc] initWithContentViewController:controller];
		popOver.popoverContentSize = controller.view.frame.size;
		
		[self.map deselectAnnotation:aboutLocation animated:YES];
		
		CLLocationCoordinate2D coordinate;
		coordinate.latitude = aboutLocation.latitude;
		coordinate.longitude = aboutLocation.longitude;
		CGPoint point = [self.map convertCoordinate:coordinate toPointToView:self.map];
		CGRect popOverRect = CGRectMake(point.x, point.y, 7, 40);
		
		[popOver presentPopoverFromRect:popOverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];	
		
	} else {
		[self presentModalViewController:controller animated:YES];		
	}
	
	
}

-(void)openSettingsView{
	SettingsViewController* controller = [[SettingsViewController alloc] initWithDelegate:self];
	
	if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
		popOver = [[UIPopoverController alloc] initWithContentViewController:controller];
		popOver.popoverContentSize = controller.view.frame.size;
		
		[self.map deselectAnnotation:settingsLocation animated:YES];
		
		CLLocationCoordinate2D coordinate;
		coordinate.latitude = settingsLocation.latitude;
		coordinate.longitude = settingsLocation.longitude;
		CGPoint point = [self.map convertCoordinate:coordinate toPointToView:self.map];
		CGRect popOverRect = CGRectMake(point.x, point.y, 7, 40);
		
		[popOver presentPopoverFromRect:popOverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];	
		
	} else {
		[self presentModalViewController:controller animated:YES];		
	}
}


-(void)closeContentView{
	if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
		[popOver dismissPopoverAnimated:YES];
	else 
		[self dismissModalViewControllerAnimated:YES];
}


#pragma mark Delegate Methods for Map Annotations and Overlays

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
	MKPolyline* line = (MKPolyline*)overlay;
	MKPolylineView*    aView = [[[MKPolylineView alloc] initWithPolyline:line] autorelease];
	
	if([line.title isEqualToString:@"ORIGINAL"]){
		aView.fillColor   = [[UIColor blueColor] colorWithAlphaComponent:0.4];
		aView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
		aView.lineWidth   = 6;
	}else if([line.title isEqualToString:@"HEUTE"]){
		aView.fillColor   = [[UIColor redColor] colorWithAlphaComponent:0.4];
		aView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
		aView.lineWidth   = 5;
	}else {
		aView.fillColor   = [[UIColor greenColor] colorWithAlphaComponent:0.4];
		aView.strokeColor = [[UIColor greenColor] colorWithAlphaComponent:0.7];
		aView.lineWidth   = 4;
	}
	
	return aView;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	if([annotation isKindOfClass:[MKUserLocation class]]){
		return nil;
	} else {
		MapLocation* mapPoint = (MapLocation*)annotation;
		mapPoint.parentViewController = self;
		return [mapPoint mapView:mapView];						
	}
}

#pragma mark Toolbar Actions

-(IBAction)focusOnBerlin{
	
	MKCoordinateRegion region;
	if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
		region.center.latitude     = 52.513031;
		region.center.longitude    = 13.427533;
		region.span.latitudeDelta  = 0.140451;
		region.span.longitudeDelta = 0.187513;
	} else {
		region.center.latitude     = 52.513089;
		region.center.longitude    = 13.389379;
		region.span.latitudeDelta  = 0.138682;
		region.span.longitudeDelta = 0.175291;
	}
	
	[self.map setRegion:region animated:YES];	
}

-(IBAction)openToolbar:(id)sender{
	
	
	UIBarButtonItem* item = (UIBarButtonItem*) sender;
	
	[UIView beginAnimations:@"toolbarAnimation" context:nil];
	[UIView setAnimationDuration:0.3];
	
	int version = settings.mapDataVersion;

	if(version >= 15 && toolbarMove == 40){
		toolbarMove = MOVE_SUBTOOLBARS_FULLL;
		backGroundImage.frame = CGRectMake(0, -120, 320, 200);
	}
	
	if(openToolbar != 0){
		[subToolbar moveUp:toolbarMove];
		openToolbar = 0;
	}else if(openToolbar == 0) {
		[subToolbar moveUp:toolbarMove*(-1)];
		openToolbar = item.tag;
	}	
	
	[UIView commitAnimations];
}

#pragma mark MapLoading

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];	
}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
	if(!mapFailAlreadyReported){
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NO_INTERNET", @"") message:NSLocalizedString(@"NO_INTERNET_LONG", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
		mapFailAlreadyReported = YES;
		[alert show];
		[alert release];
	}
}

#pragma mark Support All UI Orientations

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { 
	if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
		return YES;
	} else {
		if(interfaceOrientation == UIInterfaceOrientationPortrait)
			return YES;
	}
	return NO;
}

#pragma mark iAd Framework

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
	return YES;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)_banner
{
    if (!adVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        self.banner.frame = CGRectOffset(self.banner.frame, 0, self.banner.frame.size.height * (-1));
	    [UIView commitAnimations];
        adVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)_banner didFailToReceiveAdWithError:(NSError *)error
{
	if (adVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        self.banner.frame = CGRectOffset(self.banner.frame, 0, self.banner.frame.size.height);
        [UIView commitAnimations];
        adVisible = NO;
    }
}


#pragma mark App Lifecycle

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.map = nil;
	self.mainToolbar = nil;
}

- (void)dealloc {
	[map release];
	[mainToolbar release];
	[super dealloc];
}


@end

