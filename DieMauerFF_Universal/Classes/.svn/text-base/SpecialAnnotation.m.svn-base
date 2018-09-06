	//
	//  PointOfInterest.m
	//  MapGame
	//
	//  Created by Michael Dietz on 07.07.10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "SpecialAnnotation.h"
#import "SpecialAnnotationView.h"
#import "MainViewController.h"

@implementation SpecialAnnotation

@synthesize parentViewController;
@synthesize latitude, longitude, title, subtitle, imageName, type;

-(CLLocationCoordinate2D)coordinate{
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = self.latitude;
	coordinate.longitude = self.longitude;
	return coordinate;
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView{
	SpecialAnnotationView* annView = [[SpecialAnnotationView alloc] initWithAnnotation:self:imageName];
	annView.animatesDrop   = NO;
	annView.canShowCallout = YES;
	annView.draggable      = NO;
	
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[rightButton addTarget:self
					action:@selector(openView)
		  forControlEvents:UIControlEventTouchUpInside];
	annView.rightCalloutAccessoryView = rightButton;
	annView.calloutOffset = CGPointMake(0, 5);
	return annView;
}

-(void)openView{
	if(type == 1)
		[parentViewController openAboutView];
	else if(type == 2)
		[parentViewController openSettingsView];
}



@end
