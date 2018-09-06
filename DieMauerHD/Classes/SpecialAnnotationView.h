//
//  MGAnnotationView.h
//  MapGameiPhone
//
//  Created by Dietz, Michael on 7/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>



@interface SpecialAnnotationView : MKPinAnnotationView {

}

- (id)initWithAnnotation :(id <MKAnnotation>)annotation :(NSString*)imageName;


@end
