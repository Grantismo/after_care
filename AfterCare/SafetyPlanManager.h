//
//  SafetyPlanManager.h
//  AfterCare
//
//  Created by Lucas Best on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "WarningSign.h"
#import "CopingStrategy.h"
#import "SocialPlace.h"
#import "Person.h"
#import "Professional.h"
#import "SafeEnvironment.h"

@interface SafetyPlanManager : NSObject

-(WarningSign*) warningSignAtIndex:(int) index;
-(void) saveWarningSign:(WarningSign*) warningSign atIndex:(int) index;

-(CopingStrategy*) copingStrategyAtIndex:(int) index;
-(void) saveCopingStrategy:(CopingStrategy*) copingStrategy atIndex:(int) index;

-(SocialPlace*) placeAtIndex:(int) index;
-(void) savePlace:(SocialPlace*) place atIndex:(int) index;

-(Person*) personAtIndex:(int) index;
-(void) savePerson:(Person*) person atIndex:(int) index;

-(Professional*) professionalAtIndex:(int) index;
-(void) saveProfessional:(Professional*) professional atIndex:(int) index;

-(SafeEnvironment*) safeEnvironmentAtIndex:(int) index;
-(void) saveSafeEnvironment:(SafeEnvironment*) safeEnvironment atIndex:(int) index;

+(SafetyPlanManager*) sharedManager;

@end
