//
//  SafetyPlanScreen.h
//  AfterCare
//
//  Created by Lucas Best on 8/5/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SafetyPlanScreen <NSObject>

-(void) addToView:(UIView*) view;
-(void) removeFromSuperview;

@end
