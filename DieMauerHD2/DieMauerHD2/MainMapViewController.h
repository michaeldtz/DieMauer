//
//  FirstViewController.h
//  DieMauerHD2
//
//  Created by Michael Dietz on 28.04.14.
//  Copyright (c) 2014 Michael Dietz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBXMapKit/MBXMapKit.h>

@interface MainMapViewController : UIViewController {

    IBOutlet MBXMapView* mapView;


}

@property IBOutlet MBXMapView* mapView;

@end
