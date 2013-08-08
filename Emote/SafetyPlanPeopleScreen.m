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
    
    addButton1.titleLabel.numberOfLines = 2;
    addButton2.titleLabel.numberOfLines = 2;
    addButton3.titleLabel.numberOfLines = 2;
    
    [self refreshButtonsFromSafetyPlan];
}

-(NSString*) titleText{
    return @"Part 4: People I can ask for help.";
}

-(NSString*) descriptionText{
    return nil;
}

#pragma mark protected methods

-(NSString*) alertMessageInfoForTag:(int)tag{
    Person* person = [[SafetyPlanManager sharedManager] personAtIndex:tag];
    return [NSString stringWithFormat:@"%@:\n%@", person.name, person.phoneNumber];
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
    
    BOOL hasWarning = [[SafetyPlanManager sharedManager] personAtIndex:tag] ? TRUE : FALSE;
    
    NSString* actionString = hasWarning ? @"Edit" : @"Add";
    
    return [NSString stringWithFormat:@"%@ %@ Person", actionString, titleName];
}


-(NSString*) editPlaceholderTextForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] personAtIndex:tag].name;
}

-(NSString*) editPlaceholderText1ForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] personAtIndex:tag].phoneNumber;
}

-(NSString*) phoneNumberForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] personAtIndex:tag].phoneNumber;
}

-(UIAlertViewStyle) alertStyle{
    return UIAlertViewStyleLoginAndPasswordInput;
}

-(BOOL) shouldEditForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] personAtIndex:tag] ? TRUE : FALSE;
}

-(void) textWasEdited:(NSString *)text text1:(NSString *)text1 forTag:(int)tag{
    Person* person = nil;
    if ((text && ![text isEqualToString:@""]) && (text1 && ![text1 isEqualToString:@""])){
        person = [[Person alloc] init];
        person.name = text;
        person.phoneNumber = text1;
    }
    
    [[SafetyPlanManager sharedManager] savePerson:person atIndex:tag];
    
    [self refreshButtonsFromSafetyPlan];
}

-(void) refreshButtonsFromSafetyPlan{
    SafetyPlanManager* manager = [SafetyPlanManager sharedManager];
    
    if ([manager personAtIndex:0]) {
        [progressView setDotActivatedAtIndex:0];
        
        Person* person = [manager personAtIndex:0];
        NSString* title = [NSString stringWithFormat:@"%@\n%@", person.name, person.phoneNumber];
        
        [addButton1 setTitle:title forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:0];
        [addButton1 setTitle:@"Add your first person." forState:UIControlStateNormal];
    }
    if ([manager personAtIndex:1]) {
        [progressView setDotActivatedAtIndex:1];
        
        Person* person = [manager personAtIndex:1];
        NSString* title = [NSString stringWithFormat:@"%@\n%@", person.name, person.phoneNumber];
        
        [addButton2 setTitle:title forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:1];
        [addButton2 setTitle:@"Add your second person." forState:UIControlStateNormal];
    }
    if ([manager personAtIndex:2]) {
        [progressView setDotActivatedAtIndex:2];
        
        Person* person = [manager personAtIndex:2];
        NSString* title = [NSString stringWithFormat:@"%@\n%@", person.name, person.phoneNumber];
        
        [addButton3 setTitle:title forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:2];
        [addButton3 setTitle:@"Add your third person." forState:UIControlStateNormal];
    }
}


@end
