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
	MainViewController* parentViewController;
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



@property(assign) MainViewController* parentViewController;
@property(assign,readonly) MKPinAnnotationView* annView;
@property(assign) CLLocationCoordinate2D coord;
@property(retain) NSString* title;
@property(retain) NSString* subtitle;
@property(retain) NSString* description;
@property(retain) NSString* content;
@property(retain) NSString* webcontent;
@property(retain) NSString* imageUrl;
@property(retain) NSString* poiType;
@property(retain) NSString* imageAuthor;
@property(retain) NSString* imageLicenseURL;
@property(retain) NSString* imageCRType;
@property(assign) int       zoomType;

-(MKAnnotationView *) mapView:(MKMapView *)mapView;
-(void)showContent;

@end
