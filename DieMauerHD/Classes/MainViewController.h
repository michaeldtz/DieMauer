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


@interface MainViewController : UIViewController <MKMapViewDelegate, NewDataArrivalDelegate, ContentViewCloser> {
	
	MapDataUpdatLoader* mapUpdater;
	
	UIPopoverController* popOver;
	
#pragma mark Locations and Overlays
	NSMutableArray* pois;
	NSMutableArray* original;
	NSMutableArray* borders;
	NSMutableArray* today;
	
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

@property(nonatomic,strong) IBOutlet MKMapView*       map;
@property(nonatomic,strong) IBOutlet UINavigationBar* mainToolbar;
@property(nonatomic,strong) IBOutlet UIView*          subToolbar;
@property(nonatomic,strong) IBOutlet UIImageView*     backGroundImage;
@property(nonatomic,strong) IBOutlet UIButton*        poiButton;

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
