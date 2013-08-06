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
    
    //get core data stuff here.
}

-(NSString*) titleText{
    return @"Part 3: Places and Social Settings";
}

-(NSString*) descriptionText{
    return @"These are active, engaging locations like parks, museums, or even a friend's house, that provide a distraction.";
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
