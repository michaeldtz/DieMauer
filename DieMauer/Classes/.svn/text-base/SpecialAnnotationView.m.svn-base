	//
	//  MGAnnotationView.m
	//  MapGameiPhone
	//
	//  Created by Dietz, Michael on 7/9/10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "SpecialAnnotationView.h"
#import "MainViewController.h"

@implementation SpecialAnnotationView



- (id)initWithAnnotation:(id <MKAnnotation>)annotation:(NSString*)imageName{
    self = [super initWithAnnotation:annotation reuseIdentifier:@"CustomId"];
	
    if (self) {
        UIImage*    theImage = [UIImage imageNamed:imageName];

        if (!theImage)
            return nil;
		
        self.image = theImage;
    }    
	return self;
}


@end
