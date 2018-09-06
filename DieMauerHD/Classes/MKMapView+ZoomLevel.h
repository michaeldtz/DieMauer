//
//  MKMapView+ZoomLevel.h
//  MapGameiPhone
//
//  Created by Michael Dietz on 07.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
				  zoomLevel:(NSUInteger)zoomLevel
				   animated:(BOOL)animated;

- (void)setZoomLevel:(NSUInteger)zoomLevel
				   animated:(BOOL)animated;

@end
