//
//  UIBarButtonItem+Mover.m
//  MapGameiPhone
//
//  Created by Dietz, Michael on 7/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIView+Mover.h"


@implementation UIView (Mover)

-(void)moveUp:(float)moveBy{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - moveBy , self.frame.size.width, self.frame.size.height);
}

@end
