//
//  SafetyPlanScreen.m
//  AfterCare
//
//  Created by Lucas Best on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanScreen.h"

@interface SafetyPlanScreen ()

-(void) animateViewIn:(UIView*) view;
-(void) animateViewOut:(UIView*) view;

-(void) addDetailImageView:(UIImageView*)imageView toButton:(UIButton*) button;


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
    [self animateOut];
    
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
    addButton1.frame = CGRectMake(0.0,
                                  0.0,
                                  addButton1.frame.size.width,
                                  addButton1.frame.size.height);
    
    addButton2.frame = CGRectMake(0.0,
                                  addButton1.frame.size.height,
                                  addButton2.frame.size.width,
                                  addButton2.frame.size.height);
    
    addButton3.frame = CGRectMake(0.0,
                                  addButton1.frame.size.height + addButton2.frame.size.height,
                                  addButton3.frame.size.width,
                                  addButton3.frame.size.height);
    
    addButton4.frame = CGRectMake(0.0,
                                  addButton1.frame.size.height + addButton2.frame.size.height + addButton3.frame.size.height,
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

#pragma mark Actions

-(IBAction)addToSafetyPlan:(UIButton *)sender{
    //Let subclasses override
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

@end
