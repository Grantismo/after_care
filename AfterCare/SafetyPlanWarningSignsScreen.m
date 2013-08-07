//
//  SafetyPlanWarningSignsScreen.m
//  AfterCare
//
//  Created by Lucas Best on 8/5/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanWarningSignsScreen.h"
#import "DotProgressView.h"

#import "SafetyPlanManager.h"

@interface SafetyPlanWarningSignsScreen ()<UIAlertViewDelegate>{
    UIAlertView* editAlert;
}

-(void) refreshButtonsFromSafetyPlan;

-(void) createEditAlertFromTag:(int) tag;

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

#pragma mark UIAlertView delegate methods

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == editAlert){
        if (buttonIndex == 1){
            
            NSString* text = [alertView textFieldAtIndex:0].text;
            
            WarningSign* warningSign = nil;
            if (text && ![text isEqualToString:@""]){
                warningSign = [[WarningSign alloc] init];
                warningSign.warningSign = [alertView textFieldAtIndex:0].text;
            }
            
            [[SafetyPlanManager sharedManager] saveWarningSign:warningSign atIndex:alertView.tag];
            
            [self refreshButtonsFromSafetyPlan];
        }
    }
    else{
        if (buttonIndex == 1){
            [self createEditAlertFromTag:alertView.tag];
            [editAlert show];
        }
    }
}

#pragma mark actions

-(IBAction)addToSafetyPlan:(UIButton *)sender{
    UIAlertView* showAlert = nil;
    
    if ([[SafetyPlanManager sharedManager] warningSignAtIndex:sender.tag]){
        showAlert = [[UIAlertView alloc] initWithTitle:nil message:[[SafetyPlanManager sharedManager] warningSignAtIndex:sender.tag].warningSign delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Edit",nil];
        
        showAlert.tag = sender.tag;
    }
    else{
        [self createEditAlertFromTag:sender.tag];
        showAlert = editAlert;
    }
   
    
    [showAlert show];
}

#pragma mark private methods

-(void) refreshButtonsFromSafetyPlan{
    SafetyPlanManager* manager = [SafetyPlanManager sharedManager];
    
    if ([manager warningSignAtIndex:0]) {
        [progressView setDotActivatedAtIndex:0];
        [addButton1 setTitle:@"Your first warning sign." forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:0];
        [addButton1 setTitle:@"Add your first warning sign." forState:UIControlStateNormal];
    }
    if ([manager warningSignAtIndex:1]) {
        [progressView setDotActivatedAtIndex:1];
        [addButton2 setTitle:@"Your second warning sign." forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:1];
        [addButton2 setTitle:@"Your second warning sign." forState:UIControlStateNormal];
    }
    if ([manager warningSignAtIndex:2]) {
        [progressView setDotActivatedAtIndex:2];
        [addButton3 setTitle:@"Your third warning sign." forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:2];
        [addButton3 setTitle:@"Add your third warning sign." forState:UIControlStateNormal];
    }
}

-(void) createEditAlertFromTag:(int)tag{
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
   
    editAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ %@ Warning Sign", actionString, titleName] message:[[SafetyPlanManager sharedManager] warningSignAtIndex:tag].warningSign delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Enter", nil];
    
    editAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    editAlert.tag = tag;
    
    [editAlert textFieldAtIndex:0].text = [[SafetyPlanManager sharedManager] warningSignAtIndex:tag].warningSign;
}

@end
