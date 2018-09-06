	//
	//  PointOfInterest.m
	//  MapGame
	//
	//  Created by Michael Dietz on 07.07.10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "MapLocation.h"
#import "MainViewController.h"

@implementation MapLocation

@synthesize parentViewController, coord, annView, title, subtitle, description, poiType, content, imageUrl, webcontent, imageAuthor, imageLicenseURL, zoomType, imageCRType;


-(CLLocationCoordinate2D)coordinate{
	return coord;
}

- (NSString *)title{
	return title;
}

- (NSString *)subtitle{
	return subtitle;
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView{
	
	annView = [[MKPinAnnotationView alloc] initWithAnnotation:self reuseIdentifier:poiType];
	
		//Create Button
	if(content != nil && (![content isEqualToString:@""])){
		UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[rightButton addTarget:self action:@selector(showContent)
			  forControlEvents:UIControlEventTouchUpInside];
		annView.rightCalloutAccessoryView = rightButton;
	}
	
		//Options
	if([poiType isEqualToString:@"TODAY"])
		annView.pinColor = MKPinAnnotationColorRed;
	else if([poiType isEqualToString:@"BORDER"])
		annView.pinColor = MKPinAnnotationColorPurple;
	else if([poiType isEqualToString:@"POI"])
		annView.pinColor = MKPinAnnotationColorGreen;
	
	annView.animatesDrop = TRUE;
	annView.canShowCallout = YES;
	annView.draggable = NO;
	annView.calloutOffset = CGPointMake(-5, 5);
	
	return annView;
}

-(void)showContent{
	if(content != nil && ![content isEqualToString:@""]){
		[parentViewController openContentView:self];
	}
}

#pragma mark Dealloc

-(void)dealloc{
	[title release];
	[subtitle release];
	[description release];
	[super dealloc];
}


@end
