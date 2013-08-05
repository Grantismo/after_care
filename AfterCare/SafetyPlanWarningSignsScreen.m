//
//  SafetyPlanWarningSignsScreen.m
//  AfterCare
//
//  Created by Lucas Best on 8/5/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanWarningSignsScreen.h"

@interface SafetyPlanWarningSignsScreen (){
    IBOutlet UIButton* addFirstWarningSignButton;
    IBOutlet UIButton* addSecondWarningSignButton;
    IBOutlet UIButton* addThirdWarningSignButton;
    
    IBOutlet UIImageView* plusButton1;
    IBOutlet UIImageView* plusButton2;
    IBOutlet UIImageView* plusButton3;
}

@end

@implementation SafetyPlanWarningSignsScreen

-(void) awakeFromNib{
    plusButton1.center = CGPointMake(plusButton1.center.x, addFirstWarningSignButton.frame.size.height / 2.0);
    [addFirstWarningSignButton addSubview:plusButton1];
    
    plusButton2.center = CGPointMake(plusButton2.center.x, addSecondWarningSignButton.frame.size.height / 2.0);
    [addSecondWarningSignButton addSubview:plusButton2];
    
    
    addSecondWarningSignButton.frame = CGRectMake(0.0,
                                                  addFirstWarningSignButton.frame.size.height,
                                                  addSecondWarningSignButton.frame.size.width,
                                                  addSecondWarningSignButton.frame.size.height);
    
    plusButton3.center = CGPointMake(plusButton3.center.x, addThirdWarningSignButton.frame.size.height / 2.0);
    [addThirdWarningSignButton addSubview:plusButton3];
    
    addThirdWarningSignButton.frame = CGRectMake(0.0,
                                                 addFirstWarningSignButton.frame.size.height + addSecondWarningSignButton.frame.size.height,
                                                 addThirdWarningSignButton.frame.size.width,
                                                 addThirdWarningSignButton.frame.size.height);
    
    addFirstWarningSignButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addSecondWarningSignButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addThirdWarningSignButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

-(void) addToView:(UIView *)view{
    [view addSubview:addFirstWarningSignButton];
    [view addSubview:addSecondWarningSignButton];
    [view addSubview:addThirdWarningSignButton];
}

-(void) removeFromSuperview{
    [addFirstWarningSignButton removeFromSuperview];
    [addSecondWarningSignButton removeFromSuperview];
    [addThirdWarningSignButton removeFromSuperview];
}

-(void) animateIn{
    addFirstWarningSignButton.center = CGPointMake(addFirstWarningSignButton.superview.frame.size.width / 2.0, addFirstWarningSignButton.center.y);
    
    addSecondWarningSignButton.center = CGPointMake(addSecondWarningSignButton.superview.frame.size.width / 2.0, addSecondWarningSignButton.center.y);
    
    addThirdWarningSignButton.center = CGPointMake(addThirdWarningSignButton.superview.frame.size.width / 2.0, addThirdWarningSignButton.center.y);
}

-(void) animateOut{
    addFirstWarningSignButton.center = CGPointMake(-addFirstWarningSignButton.frame.size.width, addFirstWarningSignButton.center.y);
    addSecondWarningSignButton.center = CGPointMake(-addSecondWarningSignButton.frame.size.width, addSecondWarningSignButton.center.y);

    addThirdWarningSignButton.center = CGPointMake(-addThirdWarningSignButton.frame.size.width, addThirdWarningSignButton.center.y);

}

@end
