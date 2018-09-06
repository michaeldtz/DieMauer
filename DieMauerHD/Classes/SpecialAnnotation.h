//
//  PointOfInterest.h
//  MapGame
//
//  Created by Michael Dietz on 07.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@class MapGameViewController;
@class MainViewController;

@interface SpecialAnnotation : MKAnnotationView <MKAnnotation>  {

	float latitude;
	float longitude;
	NSString* title;
	NSString* subtitle;
	NSString* imageName;
	MainViewController* parentViewController;
	int type;
	
}

@property(strong) 	MainViewController* parentViewController;

@property(assign) float latitude;
@property(assign) float longitude;

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;
@property NSString* imageName;

@property(assign) int type;

-(MKAnnotationView *) mapView:(MKMapView *)mapView;
-(void)openView;

@end
