//
//  SafetyPlanWarningSignsScreen.m
//  AfterCare
//
//  Created by Lucas Best on 8/5/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanWarningSignsScreen.h"
#import "DotProgressView.h"

@interface SafetyPlanWarningSignsScreen ()

@end

@implementation SafetyPlanWarningSignsScreen

-(void) awakeFromNib{
    [super awakeFromNib];
    
    progressView.numberOfDots = 3;
    [progressView setActivatedDotImage:[UIImage imageNamed:@"button_orange"]];
    
    [self refreshButtonsFromSafetyPlan];
}

-(NSString*) titleText{
    return @"Part 1: Warning Signs";
}

-(NSString*) descriptionText{
    return @"These are thoughts, moods, situations or behaviors that indicate a crisis may be developing.";
}

#pragma mark protected methods

-(NSString*) alertMessageInfoForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] warningSignAtIndex:tag].warningSign;
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
    
    BOOL hasWarning = [[SafetyPlanManager sharedManager] warningSignAtIndex:tag] ? TRUE : FALSE;
    
    NSString* actionString = hasWarning ? @"Edit" : @"Add";
    
    return [NSString stringWithFormat:@"%@ %@ Warning Sign", actionString, titleName];
}

-(NSString*) editPlaceholderTextForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] warningSignAtIndex:tag].warningSign;
}

-(UIAlertViewStyle) alertStyle{
    return UIAlertViewStylePlainTextInput;
}

-(void) textWasEdited:(NSString *)text text1:(NSString *)text1 forTag:(int)tag{
    WarningSign* warningSign = nil;
    if (text && ![text isEqualToString:@""]){
        warningSign = [[WarningSign alloc] init];
        warningSign.warningSign = text;
    }
    
    [[SafetyPlanManager sharedManager] saveWarningSign:warningSign atIndex:tag];
    
    [self refreshButtonsFromSafetyPlan];
}

-(BOOL) shouldEditForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] warningSignAtIndex:tag] ? TRUE : FALSE;
}

-(void) refreshButtonsFromSafetyPlan{
    SafetyPlanManager* manager = [SafetyPlanManager sharedManager];
    
    if ([manager warningSignAtIndex:0]) {
        [progressView setDotActivatedAtIndex:0];
        [addButton1 setTitle:[manager warningSignAtIndex:0].warningSign forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:0];
        [addButton1 setTitle:@"Add your first warning sign." forState:UIControlStateNormal];
    }
    if ([manager warningSignAtIndex:1]) {
        [progressView setDotActivatedAtIndex:1];
        [addButton2 setTitle:[manager warningSignAtIndex:1].warningSign forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:1];
        [addButton2 setTitle:@"Add your second warning sign." forState:UIControlStateNormal];
    }
    if ([manager warningSignAtIndex:2]) {
        [progressView setDotActivatedAtIndex:2];
        [addButton3 setTitle:[manager warningSignAtIndex:2].warningSign forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:2];
        [addButton3 setTitle:@"Add your third warning sign." forState:UIControlStateNormal];
    }
}

@end
