//
//  SafetyPlanPeopleScreen.m
//  AfterCare
//
//  Created by Lucas Best on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanPeopleScreen.h"

@implementation SafetyPlanPeopleScreen

-(void) awakeFromNib{
    [super awakeFromNib];
    
    progressView.numberOfDots = 3;
    [progressView setActivatedDotImage:[UIImage imageNamed:@"button_blue"]];
    
    //get core data stuff here.
}

-(NSString*) titleText{
    return @"Part 4: People I can ask for help.";
}

-(NSString*) descriptionText{
    return nil;
}


@end
