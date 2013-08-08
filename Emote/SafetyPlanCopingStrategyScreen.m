//
//  SafetyPlanInternalScreen.m
//  AfterCare
//
//  Created by Lucas Best on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanCopingStrategyScreen.h"

@implementation SafetyPlanCopingStrategyScreen

-(void) awakeFromNib{
    [super awakeFromNib];
    
    progressView.numberOfDots = 3;
    [progressView setActivatedDotImage:[UIImage imageNamed:@"button_yellow"]];
    
    [self refreshButtonsFromSafetyPlan];
}

-(NSString*) titleText{
    return @"Part 2: Internal Coping Strategies";
}

-(NSString*) descriptionText{
    return @"Things I can do by myself to take my mind off my problems, like relaxation techniques, writing, or physical activity.";
}

#pragma mark protected methods

-(NSString*) alertMessageInfoForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] copingStrategyAtIndex:tag].copingStrategy;
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
    
    BOOL hasWarning = [[SafetyPlanManager sharedManager] copingStrategyAtIndex:tag] ? TRUE : FALSE;
    
    NSString* actionString = hasWarning ? @"Edit" : @"Add";
    
    return [NSString stringWithFormat:@"%@ %@ Strategy", actionString, titleName];
}

-(NSString*) editPlaceholderTextForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] copingStrategyAtIndex:tag].copingStrategy;
}

-(UIAlertViewStyle) alertStyle{
    return UIAlertViewStylePlainTextInput;
}

-(void) textWasEdited:(NSString *)text text1:(NSString *)text1 forTag:(int)tag{
    CopingStrategy* copingStrategy = nil;
    if (text && ![text isEqualToString:@""]){
        copingStrategy = [[CopingStrategy alloc] init];
        copingStrategy.copingStrategy = text;
    }
    
    [[SafetyPlanManager sharedManager] saveCopingStrategy:copingStrategy atIndex:tag];
    
    [self refreshButtonsFromSafetyPlan];
}

-(BOOL) shouldEditForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] copingStrategyAtIndex:tag] ? TRUE : FALSE;
}

-(void) refreshButtonsFromSafetyPlan{
    SafetyPlanManager* manager = [SafetyPlanManager sharedManager];
    
    if ([manager copingStrategyAtIndex:0]) {
        [progressView setDotActivatedAtIndex:0];
        [addButton1 setTitle:[manager copingStrategyAtIndex:0].copingStrategy forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:0];
        [addButton1 setTitle:@"Add your first strategy." forState:UIControlStateNormal];
    }
    if ([manager copingStrategyAtIndex:1]) {
        [progressView setDotActivatedAtIndex:1];
        [addButton1 setTitle:[manager copingStrategyAtIndex:1].copingStrategy forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:1];
        [addButton2 setTitle:@"Add your second strategy." forState:UIControlStateNormal];
    }
    if ([manager copingStrategyAtIndex:2]) {
        [progressView setDotActivatedAtIndex:2];
        [addButton1 setTitle:[manager copingStrategyAtIndex:2].copingStrategy forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:2];
        [addButton3 setTitle:@"Add your third strategy." forState:UIControlStateNormal];
    }
}

@end
