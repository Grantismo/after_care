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
