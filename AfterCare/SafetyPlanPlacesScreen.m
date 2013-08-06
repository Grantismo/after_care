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

-(NSString*) titleText{
    return @"Part 2: Internal Coping Strategies";
}

-(NSString*) descriptionText{
    return @"Things I can do by myself to take my mind off my problems, like relaxation techniques, writing, or physical activity.";
}


#pragma mark actions

-(IBAction)addToSafetyPlan:(UIButton *)sender{
//    NSString* titleName = nil;
//    switch (sender.tag) {
//        case WarningSignTag_First:
//            titleName = @"First";
//            break;
//        case WarningSignTag_Second:
//            titleName = @"Second";
//            break;
//        case WarningSignTag_Third:
//            titleName = @"Third";
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    UIAlertView* addWarningAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Add %@ Warning Sign", titleName] message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Enter", nil];
//    
//    addWarningAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    addWarningAlert.tag = sender.tag;
//    
//    [addWarningAlert show];
}

@end
