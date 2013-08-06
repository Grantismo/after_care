//
//  SafetyPlanInternalScreen.m
//  AfterCare
//
//  Created by Lucas Best on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanInternalScreen.h"

@implementation SafetyPlanInternalScreen

-(void) awakeFromNib{
    [super awakeFromNib];
    
    progressView.numberOfDots = 3;
    [progressView setActivatedDotImage:[UIImage imageNamed:@"button_yellow"]];
    
    //get core data stuff here.
}

-(NSString*) titleText{
    return @"Part 2: Internal Coping Strategies";
}

-(NSString*) descriptionText{
    return @"Things I can do by myself to take my mind off my problems, like relaxation techniques, writing, or physical activity.";
}


@end
