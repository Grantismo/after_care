//
//  SafetyPlanProfessionalsScreen.m
//  AfterCare
//
//  Created by Lucas Best on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanProfessionalsScreen.h"

@implementation SafetyPlanProfessionalsScreen

-(void) awakeFromNib{
    [super awakeFromNib];
    
    progressView.numberOfDots = 3;
    [progressView setActivatedDotImage:[UIImage imageNamed:@"button_red"]];
    
    //get core data stuff here.
}

-(NSString*) titleText{
    return @"Part 5: Professionals and Agencies.";
}

-(NSString*) descriptionText{
    return @"It's helpful to have contact information for professionals, clinics, urgent care services, and lifelines. Enter yours here.";
}

@end
