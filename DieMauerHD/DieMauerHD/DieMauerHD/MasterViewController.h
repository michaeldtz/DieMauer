//
//  MasterViewController.h
//  DieMauerHD
//
//  Created by Michael Dietz on 28.04.14.
//  Copyright (c) 2014 Michael Dietz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
