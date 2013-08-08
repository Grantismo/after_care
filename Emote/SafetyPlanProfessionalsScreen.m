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
    
    progressView.numberOfDots = 4;
    [progressView setActivatedDotImage:[UIImage imageNamed:@"button_red"]];
    
    addButton1.titleLabel.numberOfLines = 2;
    addButton2.titleLabel.numberOfLines = 2;
    addButton3.titleLabel.numberOfLines = 2;
    addButton4.titleLabel.numberOfLines = 2;
    
    [self refreshButtonsFromSafetyPlan];
}

-(NSString*) titleText{
    return @"Part 5: Professionals and Agencies.";
}

-(NSString*) descriptionText{
    return @"It's helpful to have contact information for professionals, clinics, urgent care services, and lifelines. Enter yours here.";
}

#pragma mark actions

-(IBAction)addToSafetyPlan:(UIButton *)sender{
    if (sender.tag == 3){
        NSURL *url = [NSURL URLWithString:@"telprompt://18002738255"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else [super addToSafetyPlan:sender];
}

#pragma mark protected methods

-(NSString*) alertMessageInfoForTag:(int)tag{
    Professional* prof = [[SafetyPlanManager sharedManager] professionalAtIndex:tag];
    return [NSString stringWithFormat:@"%@:\n%@", prof.name, prof.phoneNumber];
}

-(NSString*) editAlertTitleForTag:(int)tag{
    NSString* titleName = nil;
    switch (tag) {
        case 0:
            titleName = @"Primary Clinician";
            break;
        case 1:
            titleName = @"Secondary Clinician";
            break;
        case 2:
            titleName = @"urgent care service";
            break;
            
        default:
            break;
    }
    
    BOOL hasWarning = [[SafetyPlanManager sharedManager] professionalAtIndex:tag] ? TRUE : FALSE;
    
    NSString* actionString = hasWarning ? @"Edit" : @"Add";
    
    return [NSString stringWithFormat:@"%@ your %@", actionString, titleName];
}


-(NSString*) editPlaceholderTextForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] professionalAtIndex:tag].name;
}

-(NSString*) editPlaceholderText1ForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] professionalAtIndex:tag].phoneNumber;
}

-(NSString*) phoneNumberForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] professionalAtIndex:tag].phoneNumber;
}

-(UIAlertViewStyle) alertStyle{
    return UIAlertViewStyleLoginAndPasswordInput;
}

-(BOOL) shouldEditForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] professionalAtIndex:tag] ? TRUE : FALSE;
}

-(void) textWasEdited:(NSString *)text text1:(NSString *)text1 forTag:(int)tag{
    Professional* prof = nil;
    if ((text && ![text isEqualToString:@""]) && (text1 && ![text1 isEqualToString:@""])){
        prof = [[Professional alloc] init];
        prof.name = text;
        prof.phoneNumber = text1;
    }
    
    [[SafetyPlanManager sharedManager] saveProfessional:prof atIndex:tag];
    
    [self refreshButtonsFromSafetyPlan];
}

-(void) refreshButtonsFromSafetyPlan{
    SafetyPlanManager* manager = [SafetyPlanManager sharedManager];
    
    if ([manager professionalAtIndex:0]) {
        [progressView setDotActivatedAtIndex:0];
        
        Professional* prof = [manager professionalAtIndex:0];
        NSString* title = [NSString stringWithFormat:@"%@\n%@", prof.name, prof.phoneNumber];
        
        [addButton1 setTitle:title forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:0];
        [addButton1 setTitle:@"Add your primary clinician." forState:UIControlStateNormal];
    }
    if ([manager professionalAtIndex:1]) {
        [progressView setDotActivatedAtIndex:1];
        
        Professional* prof = [manager professionalAtIndex:1];
        NSString* title = [NSString stringWithFormat:@"%@\n%@", prof.name, prof.phoneNumber];
        
        [addButton2 setTitle:title forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:1];
        [addButton2 setTitle:@"Add your secondary clinician." forState:UIControlStateNormal];
    }
    if ([manager professionalAtIndex:2]) {
        [progressView setDotActivatedAtIndex:2];
        
        Professional* prof = [manager professionalAtIndex:2];
        NSString* title = [NSString stringWithFormat:@"%@\n%@", prof.name, prof.phoneNumber];
        
        [addButton3 setTitle:title forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:2];
        [addButton3 setTitle:@"Add your urgent care service." forState:UIControlStateNormal];
    }
    
    [addButton4 setTitle:@"Suicide Prevention Lifeline:\n1-800-237-TALK" forState:UIControlStateNormal];
    [progressView setDotActivatedAtIndex:3];
}

@end
