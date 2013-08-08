//
//  SafetyPlanPlacesScreen.m
//  AfterCare
//
//  Created by Lucas Best on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanPlacesScreen.h"
#import "DotProgressView.h"

@interface SafetyPlanPlacesScreen ()

@end

@implementation SafetyPlanPlacesScreen

-(void) awakeFromNib{
    [super awakeFromNib];
    
    progressView.numberOfDots = 3;
    [progressView setActivatedDotImage:[UIImage imageNamed:@"button_green"]];
    
    addButton1.titleLabel.numberOfLines = 2;
    addButton2.titleLabel.numberOfLines = 2;
    addButton3.titleLabel.numberOfLines = 2;

    
    [self refreshButtonsFromSafetyPlan];
}

-(NSString*) titleText{
    return @"Part 3: Places and Social Settings";
}

-(NSString*) descriptionText{
    return @"These are active, engaging locations like parks, museums, or even a friend's house, that provide a distraction.";
}

#pragma mark protected methods

-(NSString*) alertMessageInfoForTag:(int)tag{
    SocialPlace* place = [[SafetyPlanManager sharedManager] placeAtIndex:tag];
    return [NSString stringWithFormat:@"%@:\n%@", place.name, place.phoneNumber];
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
    
    BOOL hasWarning = [[SafetyPlanManager sharedManager] placeAtIndex:tag] ? TRUE : FALSE;
    
    NSString* actionString = hasWarning ? @"Edit" : @"Add";
    
    return [NSString stringWithFormat:@"%@ %@ Place", actionString, titleName];
}


-(NSString*) editPlaceholderTextForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] placeAtIndex:tag].name;
}

-(NSString*) editPlaceholderText1ForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] placeAtIndex:tag].phoneNumber;
}

-(NSString*) phoneNumberForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] placeAtIndex:tag].phoneNumber;
}

-(UIAlertViewStyle) alertStyle{
    return UIAlertViewStyleLoginAndPasswordInput;
}

-(BOOL) shouldEditForTag:(int)tag{
    return [[SafetyPlanManager sharedManager] placeAtIndex:tag] ? TRUE : FALSE;
}

-(void) textWasEdited:(NSString *)text text1:(NSString *)text1 forTag:(int)tag{
    SocialPlace* place = nil;
    if ((text && ![text isEqualToString:@""]) && (text1 && ![text1 isEqualToString:@""])){
        place = [[SocialPlace alloc] init];
        place.name = text;
        place.phoneNumber = text1;
    }

    [[SafetyPlanManager sharedManager] savePlace:place atIndex:tag];
    
    [self refreshButtonsFromSafetyPlan];
}

-(void) refreshButtonsFromSafetyPlan{
    SafetyPlanManager* manager = [SafetyPlanManager sharedManager];
    
    if ([manager placeAtIndex:0]) {
        [progressView setDotActivatedAtIndex:0];
        
        SocialPlace* place = [manager placeAtIndex:0];
        NSString* title = [NSString stringWithFormat:@"%@\n%@", place.name, place.phoneNumber];
        
        [addButton1 setTitle:title forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:0];
        [addButton1 setTitle:@"Add your first place." forState:UIControlStateNormal];
    }
    if ([manager placeAtIndex:1]) {
        [progressView setDotActivatedAtIndex:1];
        
        SocialPlace* place = [manager placeAtIndex:1];
        NSString* title = [NSString stringWithFormat:@"%@\n%@", place.name, place.phoneNumber];
        
        [addButton2 setTitle:title forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:1];
        [addButton2 setTitle:@"Add your second place." forState:UIControlStateNormal];
    }
    if ([manager placeAtIndex:2]) {
        [progressView setDotActivatedAtIndex:2];
        
        SocialPlace* place = [manager placeAtIndex:2];
        NSString* title = [NSString stringWithFormat:@"%@\n%@", place.name, place.phoneNumber];
        
        [addButton3 setTitle:title forState:UIControlStateNormal];
    }
    else{
        [progressView setDotDeactivatedAtIndex:2];
        [addButton3 setTitle:@"Add your third place." forState:UIControlStateNormal];
    }
}

@end
