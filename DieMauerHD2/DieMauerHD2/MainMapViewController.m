//
//  FirstViewController.m
//  DieMauerHD2
//
//  Created by Michael Dietz on 28.04.14.
//  Copyright (c) 2014 Michael Dietz. All rights reserved.
//

#import "MainMapViewController.h"

@interface MainMapViewController ()

@end

@implementation MainMapViewController

@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [mapView setMapID:@"midtz.i3jii9b4"];
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSLog(@"Reloading");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
