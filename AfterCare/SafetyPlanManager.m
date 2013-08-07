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
#define COPING_STRATEGY_PATH_HEADER @"CopingStrategy"
#define SOCIAL_PLACE_PATH_HEADER @"SocialPlace"
#define PERSON_PATH_HEADER @"Person"
#define PROFESSIONAL_PATH_HEADER @"Professional"
#define SAFE_ENVIRONMENT_PATH_HEADER @"SafeEnvironment"

@implementation SafetyPlanManager

-(WarningSign*) warningSignAtIndex:(int)index{
    return [[DataManager sharedDataManager] readObjectFromFile:[NSString stringWithFormat:@"%@.%d", WARNING_SIGN_PATH_HEADER, index]];
}

-(void) saveWarningSign:(WarningSign *)warningSign atIndex:(int)index{
    [[DataManager sharedDataManager] writeObject:warningSign toFile:[NSString stringWithFormat:@"%@.%d", WARNING_SIGN_PATH_HEADER, index]];
}

-(CopingStrategy*) copingStrategyAtIndex:(int)index{
    return [[DataManager sharedDataManager] readObjectFromFile:[NSString stringWithFormat:@"%@.%d", COPING_STRATEGY_PATH_HEADER, index]];
}

-(void) saveCopingStrategy:(CopingStrategy *)copingStrategy atIndex:(int)index{
    [[DataManager sharedDataManager] writeObject:copingStrategy toFile:[NSString stringWithFormat:@"%@.%d", COPING_STRATEGY_PATH_HEADER, index]];
}

-(SocialPlace*) placeAtIndex:(int)index{
    return [[DataManager sharedDataManager] readObjectFromFile:[NSString stringWithFormat:@"%@.%d", SOCIAL_PLACE_PATH_HEADER, index]];
}

-(void) savePlace:(SocialPlace *)place atIndex:(int)index{
    [[DataManager sharedDataManager] writeObject:place toFile:[NSString stringWithFormat:@"%@.%d", SOCIAL_PLACE_PATH_HEADER, index]];
}

-(Person*) personAtIndex:(int)index{
    return [[DataManager sharedDataManager] readObjectFromFile:[NSString stringWithFormat:@"%@.%d", PERSON_PATH_HEADER, index]];
}

-(void) savePerson:(Person *)person atIndex:(int)index{
    [[DataManager sharedDataManager] writeObject:person toFile:[NSString stringWithFormat:@"%@.%d", PERSON_PATH_HEADER, index]];
}

-(Professional*) professionalAtIndex:(int)index{
    return [[DataManager sharedDataManager] readObjectFromFile:[NSString stringWithFormat:@"%@.%d", PROFESSIONAL_PATH_HEADER, index]];
}

-(void) saveProfessional:(Professional *)professional atIndex:(int)index{
    [[DataManager sharedDataManager] writeObject:professional toFile:[NSString stringWithFormat:@"%@.%d", PROFESSIONAL_PATH_HEADER, index]];
}

-(SafeEnvironment*) safeEnvironmentAtIndex:(int)index{
    return [[DataManager sharedDataManager] readObjectFromFile:[NSString stringWithFormat:@"%@.%d", SAFE_ENVIRONMENT_PATH_HEADER, index]];
}

-(void) saveSafeEnvironment:(SafeEnvironment *)safeEnvironment atIndex:(int)index{
    [[DataManager sharedDataManager] writeObject:professional toFile:[NSString stringWithFormat:@"%@.%d", SAFE_ENVIRONMENT_PATH_HEADER, index]];
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
