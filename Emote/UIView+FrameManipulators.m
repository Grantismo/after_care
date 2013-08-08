//
//  UIView+FrameManipulators.m
//  AfterCare
//
//  Created by Lucas Best on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "UIView+FrameManipulators.h"

@implementation UIView (FrameManipulators)

-(void) setOrigin:(CGPoint)origin{
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}

@end
