//
//  DetailViewController.h
//  DieMauerHD
//
//  Created by Michael Dietz on 28.04.14.
//  Copyright (c) 2014 Michael Dietz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
