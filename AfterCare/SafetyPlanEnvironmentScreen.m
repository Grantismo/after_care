//
//  SafetyPlanEnvironmentScreen.m
//  AfterCare
//
//  Created by Lucas Best on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanEnvironmentScreen.h"

@implementation SafetyPlanEnvironmentScreen

-(void) awakeFromNib{
    progressView.numberOfDots = 2;
    [progressView setActivatedDotImage:[UIImage imageNamed:@"button_green"]];
    
    addButton1.titleLabel.numberOfLines = 2;
    addButton2.titleLabel.numberOfLines = 2;
    
    CGSize frameSize = [addButton1.titleLabel.text sizeWithFont:addButton1.titleLabel.font constrainedToSize:CGSizeMake(addButton1.frame.size.width, MAXFLOAT)];
    
//    addButton1.frame = CGRectMake(addButton1.frame.origin.x,
//                                  addButton1.frame.origin.y,
//                                  addButton1.frame.size.width,
//                                  frameSize.height);
    
    [super awakeFromNib];
    
    //get core data stuff here.
}

-(NSString*) titleText{
    return @"Part 6: A Safe Environment.";
}

-(NSString*) descriptionText{
    return nil;
}

@end
