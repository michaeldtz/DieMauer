	//
	//  RootViewController.h
	//  MapGameiPhone
	//
	//  Created by Michael Dietz on 07.07.10.
	//  Copyright __MyCompanyName__ 2010. All rights reserved.
	//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapLocation.h"
#import "MapDataLoader.h"
#import "SettingsAccess.h"
#import "MapDataUpdatLoader.h"
#import "ContentViewController.h"
#import "SpecialAnnotation.h"
#import <iAd/iAd.h>

@interface MainViewController : UIViewController <MKMapViewDelegate, NewDataArrivalDelegate, ContentViewCloser, ADBannerViewDelegate> {
	
	MapDataUpdatLoader* mapUpdater;
	
	UIPopoverController* popOver;
	
#pragma mark Locations and Overlays
	NSMutableArray* pois;
	NSMutableArray* original;
	NSMutableArray* borders;
	NSMutableArray* today;
	
	IBOutlet ADBannerView* banner;
	BOOL adVisible;

	SettingsAccess* settings;
	
#pragma mark SpecialAnnotations
	SpecialAnnotation* aboutLocation;
	SpecialAnnotation* settingsLocation;
	
#pragma mark Map
	IBOutlet MKMapView* map;
	
#pragma mark Toolbars
	IBOutlet UINavigationBar* mainToolbar;
	IBOutlet UIView* subToolbar;
	IBOutlet UIImageView* backGroundImage;
	
	IBOutlet UIButton* poiButton;
	
	int openToolbar;
	int toolbarMove;
	
	BOOL bannerVisible;
	BOOL mapFailAlreadyReported;
	BOOL updateLocation;
	BOOL supressUpdatePopup;
}

@property(nonatomic,retain) IBOutlet MKMapView*       map;
@property(nonatomic,retain) IBOutlet UINavigationBar* mainToolbar;
@property(nonatomic,retain) IBOutlet UIView*          subToolbar;
@property(nonatomic,retain) IBOutlet UIImageView*     backGroundImage;
@property(nonatomic,retain) IBOutlet UIButton*        poiButton;
@property(nonatomic,retain) IBOutlet ADBannerView*    banner;

#pragma mark Map Initialization
-(void)initLocalizedViewStrings;
-(void)initDefaultMapContent;
-(void)startMapUpdate;

#pragma mark All Other Methods
-(IBAction)addPOIS;
-(IBAction)addToday;
-(IBAction)addOriginal;
-(IBAction)addBorders;
-(IBAction)addApplicationLocationFlag;

-(IBAction)focusOnBerlin;

-(IBAction)openToolbar:(id)sender;

-(void)openContentView:(MapLocation*)location;
-(void)openAboutView;
-(void)openSettingsView;

@end
