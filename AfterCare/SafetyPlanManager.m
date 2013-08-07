//
//  SafetyPlanManager.m
//  AfterCare
//
//  Created by Lucas Best on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanManager.h"
#import "DataManager.h"

#define WARNING_SIGN_PATH_HEADER @"WarningSign"

@implementation SafetyPlanManager

-(WarningSign*) warningSignAtIndex:(int)index{
    return [[DataManager sharedDataManager] readObjectFromFile:[NSString stringWithFormat:@"%@.%d", WARNING_SIGN_PATH_HEADER, index]];
}

-(void) saveWarningSign:(WarningSign *)warningSign atIndex:(int)index{
    [[DataManager sharedDataManager] writeObject:warningSign toFile:[NSString stringWithFormat:@"%@.%d", WARNING_SIGN_PATH_HEADER, index]];
}

+(SafetyPlanManager*) sharedManager{
    static SafetyPlanManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SafetyPlanManager alloc] init];
    });
    return sharedInstance;
}

@end
