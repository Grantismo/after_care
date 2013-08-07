//
//  SafetyPlanScreen.m
//  AfterCare
//
//  Created by Lucas Best on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanScreen.h"

@interface SafetyPlanScreen ()<UIAlertViewDelegate>{
    UIAlertView* editAlert;
}

-(void) animateViewIn:(UIView*) view;
-(void) animateViewOut:(UIView*) view;

-(void) addDetailImageView:(UIImageView*)imageView toButton:(UIButton*) button;

-(void) createEditAlertFromTag:(int) tag;

@end

@implementation SafetyPlanScreen

-(void) awakeFromNib{
    [self addDetailImageView:detailImage1 toButton:addButton1];
    [self addDetailImageView:detailImage2 toButton:addButton2];
    [self addDetailImageView:detailImage3 toButton:addButton3];
    [self addDetailImageView:detailImage4 toButton:addButton4];
    
    addButton1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addButton2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addButton3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addButton4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [progressView setDeactivatedDotImage:[UIImage imageNamed:@"button_off"]];
    
    [self layoutViews];
}

-(NSString*) titleText{
    //Let subclasses override
    return nil;
}

-(NSString*) descriptionText{
    //Let subclasses override
    return nil;
}

-(void) addToView:(UIView *)view{
    [view addSubview:addButton1];
    [view addSubview:addButton2];
    [view addSubview:addButton3];
    [view addSubview:addButton4];
}

-(void) removeFromSuperview{
    [addButton1 removeFromSuperview];
    [addButton2 removeFromSuperview];
    [addButton3 removeFromSuperview];
    [addButton4 removeFromSuperview];
}

-(void) layoutViews{
    float numButtons = (addButton1 ? 1 : 0) + (addButton2 ? 1 :0) + (addButton3 ? 1 :0) + (addButton4 ? 1 :0);
    
    CGFloat frameStep = addButton1.superview.frame.size.height/ numButtons;
    
    addButton1.frame = CGRectMake(addButton1.frame.origin.x,
                                  0.0,
                                  addButton1.frame.size.width,
                                  addButton1.frame.size.height);
    
    addButton2.frame = CGRectMake(addButton2.frame.origin.x,
                                  MIN(frameStep, addButton1.frame.size.height + 10.0),
                                  addButton2.frame.size.width,
                                  addButton2.frame.size.height);
    
    addButton3.frame = CGRectMake(addButton3.frame.origin.x,
                                  MIN(frameStep * 2.0, addButton1.frame.size.height + addButton2.frame.size.height + 20.0),
                                  addButton3.frame.size.width,
                                  addButton3.frame.size.height);
    
    addButton4.frame = CGRectMake(addButton4.frame.origin.x,
                                  MIN(frameStep * 3.0, addButton1.frame.size.height + addButton2.frame.size.height + addButton3.frame.size.height + 30.0),
                                  addButton4.frame.size.width,
                                  addButton4.frame.size.height);
}

-(void) animateIn{
    [self animateViewIn:addButton1];
    [self animateViewIn:addButton2];
    [self animateViewIn:addButton3];
    [self animateViewIn:addButton4];
}

-(void) animateOut{
    [self animateViewOut:addButton1];
    [self animateViewOut:addButton2];
    [self animateViewOut:addButton3];
    [self animateViewOut:addButton4];
}

#pragma mark UIAlertView delegate methods

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == editAlert){
        if (buttonIndex == 1){
            NSString* text = [alertView textFieldAtIndex:0].text;
            [self textWasEdited:text forTag:alertView.tag];
        }
    }
    else{
        if (buttonIndex == 1){
            [self createEditAlertFromTag:alertView.tag];
            [editAlert show];
        }
    }
}

#pragma mark Actions

-(IBAction)addToSafetyPlan:(UIButton *)sender{
    UIAlertView* showAlert = nil;
    
    if ([self shouldEditForTag:sender.tag]){
        showAlert = [[UIAlertView alloc] initWithTitle:nil message:[self alertMessageInfoForTag:sender.tag] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Edit",nil];
        
        showAlert.tag = sender.tag;
    }
    else{
        [self createEditAlertFromTag:sender.tag];
        showAlert = editAlert;
    }
    
    
    [showAlert show];
}

#pragma mark protected methods

-(NSString*) alertMessageInfoForTag:(int)tag{
    //Let subclasses override
    return nil;
}

-(NSString*) editAlertTextForTag:(int)tag{
    //Let subclasses override
    return nil;
}

-(NSString*) editPlaceholderTextForTag:(int)tag{
    //Let subclasses override
    return nil;
}

-(void) textWasEdited:(NSString *)text forTag:(int)tag{
    //Let subclasses override
}

-(BOOL) shouldEditForTag:(int)tag{
    //Let subclasses override
    return FALSE;
}

#pragma mark private methods

-(void) animateViewIn:(UIView *)view{
    view.center = CGPointMake(view.superview.frame.size.width / 2.0, view.center.y);
}

-(void) animateViewOut:(UIView *)view{
    view.center = CGPointMake(-view.superview.frame.size.width, view.center.y);
}

-(void) addDetailImageView:(UIImageView *)imageView toButton:(UIButton *)button{
    imageView.center = CGPointMake(imageView.center.x, button.frame.size.height / 2.0);
    [button addSubview:imageView];
}

-(void) createEditAlertFromTag:(int)tag{
    editAlert = [[UIAlertView alloc] initWithTitle:[self editAlertTextForTag:tag] message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Enter", nil];
    
    editAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    editAlert.tag = tag;
    
    [editAlert textFieldAtIndex:0].text = [self editPlaceholderTextForTag:tag];
}

@end
