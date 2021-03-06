	//
	//  Point.h
	//  DieMauer
	//
	//  Created by Dietz, Michael on 8/31/10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import <Foundation/Foundation.h>

typedef enum PointPointType
{
	POINT_TYPE_CONNECTION_CONTINUE = 0,
	POINT_TYPE_CONNECTION_START    = 1,
	POINT_TYPE_CONNECTION_END      = 2,
	POINT_TYPE_POI                 = 3,
	
} PointPointType;

@interface MapPoint : NSObject {

	NSString*      title;
	NSString*      subtitle;
	NSString*      content;
	NSString*      webcontent;
	NSString*      imageurl;
	NSString*      imageAuthor;
	NSString*      imageLicenseURL;
	NSString*      imageCRType;
	
	float          latitude;
	float          longitude;
	BOOL           start;
	int            zoomType;
	PointPointType type;
	
}

@property(assign) float latitude;
@property(assign) float longitude;
@property(assign) NSString* title;
@property(assign) NSString* subtitle;
@property(retain) NSString* content;
@property(retain) NSString* webcontent;
@property(retain) NSString* imageurl;
@property(retain) NSString* imageAuthor;
@property(retain) NSString* imageLicenseURL;
@property(retain) NSString* imageCRType;
@property(assign) BOOL  start;
@property(assign) int   zoomType;
@property(assign) PointPointType type;

@end
