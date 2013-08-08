//
//  SafetyPlanViewController.h
//  AfterCare
//
//  Created by Lucas Best on 8/2/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class SafetyPlanViewController;

@protocol SafetyPlanDelegate <NSObject>

-(void) dismissSafetyPlayController:(SafetyPlanViewController*) controller;

@end

@interface SafetyPlanViewController : UIViewController

@property (nonatomic, assign) id<SafetyPlanDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

-(void) addBackButton;

-(void) animateArrow:(BOOL) toSide withDuration:(NSTimeInterval) duration;

@end
