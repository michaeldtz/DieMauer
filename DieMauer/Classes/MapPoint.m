	//
	//  Point.m
	//  DieMauer
	//
	//  Created by Dietz, Michael on 8/31/10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "MapPoint.h"


@implementation MapPoint

@synthesize latitude, longitude, subtitle, title, start, type, content, webcontent, imageurl, zoomType, imageAuthor, imageLicenseURL, imageCRType;


-(void)dealloc{
	[super dealloc];
}

@end
