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
    [super awakeFromNib];
    
    progressView.numberOfDots = 2;
    [progressView setActivatedDotImage:[UIImage imageNamed:@"button_green"]];
    
    addButton1.titleLabel.numberOfLines = 2;
    addButton2.titleLabel.numberOfLines = 2;
    
    [self refreshButtonsFromSafetyPlan];
}

-(NSString*) titleText{
    return @"Part 6: A Safe Environment.";
}

-(NSString*) descriptionText{
    return nil;
}

#pragma mark protected methods

-(NSString*) alertMessageInfoForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] safeEnvironmentAtIndex:tag].safeEnvironment;
}

-(NSString*) editAlertTitleForTag:(int)tag{
    NSString* titleName = nil;
    switch (tag) {
        case 0:
            titleName = @"First";
            break;
        case 1:
            titleName = @"Second";
            break;
        case 2:
            titleName = @"Third";
            break;
            
        default:
            break;
    }
    
    BOOL hasWarning = [[SafetyPlanManager sharedManager] safeEnvironmentAtIndex:tag] ? TRUE : FALSE;
    
    NSString* actionString = hasWarning ? @"Edit" : @"Add";
    
    return [NSString stringWithFormat:@"%@ %@ Safe Environment", actionString, titleName];
}

-(NSString*) editPlaceholderTextForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] safeEnvironmentAtIndex:tag].safeEnvironment;
}

-(UIAlertViewStyle) alertStyle{
    return UIAlertViewStylePlainTextInput;
}

-(void) textWasEdited:(NSString *)text text1:(NSString *)text1 forTag:(int)tag{
    SafeEnvironment* safeEnvironment = nil;
    if (text && ![text isEqualToString:@""]){
        safeEnvironment = [[SafeEnvironment alloc] init];
        safeEnvironment.safeEnvironment = text;
    }
    
    [[SafetyPlanManager sharedManager] saveSafeEnvironment:safeEnvironment atIndex:tag];
    
    [self refreshButtonsFromSafetyPlan];
}

-(BOOL) shouldEditForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] safeEnvironmentAtIndex:tag] ? TRUE : FALSE;
}

-(void) refreshButtonsFromSafetyPlan{
    SafetyPlanManager* manager = [SafetyPlanManager sharedManager];
    
    if ([manager safeEnvironmentAtIndex:0]) {
        [progressView setDotActivatedAtIndex:0];
        [addButton1 setTitle:@"Your first warning sign." forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:0];
        [addButton1 setTitle:@"Add your first warning sign." forState:UIControlStateNormal];
    }
    if ([manager safeEnvironmentAtIndex:1]) {
        [progressView setDotActivatedAtIndex:1];
        [addButton2 setTitle:@"Your second warning sign." forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:1];
        [addButton2 setTitle:@"Add your second warning sign." forState:UIControlStateNormal];
    }
}

@end
