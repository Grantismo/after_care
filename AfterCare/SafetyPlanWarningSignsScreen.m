//
//  SafetyPlanWarningSignsScreen.m
//  AfterCare
//
//  Created by Lucas Best on 8/5/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanWarningSignsScreen.h"
#import "DotProgressView.h"

@interface SafetyPlanWarningSignsScreen ()<UIAlertViewDelegate>

@end

@implementation SafetyPlanWarningSignsScreen

-(void) awakeFromNib{
    [super awakeFromNib];
    
    //get core data stuff here.
}

-(NSString*) titleText{
    return @"Part 1: Warning Signs";
}

-(NSString*) descriptionText{
    return @"These are thoughts, moods, situations or behaviors that indicate a crisis may be developing.";
}

#pragma mark UIAlertView delegate methods

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        //Add to core data;
        
        switch (alertView.tag) {
            case 0:
                
                break;
            case 1:
                
                break;
            case 2:
               
                break;
                
            default:
                break;
        }
    }
}

#pragma mark actions

-(IBAction)addToSafetyPlan:(UIButton *)sender{
    NSString* titleName = nil;
    switch (sender.tag) {
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
    
    
    UIAlertView* addWarningAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Add %@ Warning Sign", titleName] message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Enter", nil];
    
    addWarningAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    addWarningAlert.tag = sender.tag;
    
    [addWarningAlert show];
}

@end
