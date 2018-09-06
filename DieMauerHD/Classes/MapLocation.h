	//
	//  PointOfInterest.h
	//  MapGame
	//
	//  Created by Michael Dietz on 07.07.10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class MainViewController;

@interface MapLocation : MKAnnotationView <MKAnnotation>  {
	
	MKPinAnnotationView* annView;
	MainViewController* __weak parentViewController;
	CLLocationCoordinate2D coord;
	NSString* title;
	NSString* subtitle;
	NSString* description;
	NSString* content;
	NSString* webcontent;
	NSString* imageUrl;
	NSString* poiType;
	NSString* imageAuthor;
	NSString* imageLicenseURL;
	NSString* imageCRType;
	BOOL      alreadyFalling;
	int       zoomType;
}



@property(weak) MainViewController* parentViewController;
@property(readonly) MKPinAnnotationView* annView;
@property(assign) CLLocationCoordinate2D coord;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;
@property(strong) NSString* description;
@property(strong) NSString* content;
@property(strong) NSString* webcontent;
@property(strong) NSString* imageUrl;
@property(strong) NSString* poiType;
@property(strong) NSString* imageAuthor;
@property(strong) NSString* imageLicenseURL;
@property(strong) NSString* imageCRType;
@property(assign) int       zoomType;

-(MKAnnotationView *) mapView:(MKMapView *)mapView;
-(void)showContent;

@end
