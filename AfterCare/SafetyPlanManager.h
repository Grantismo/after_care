//
//  SafetyPlanManager.h
//  AfterCare
//
//  Created by Lucas Best on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "WarningSign.h"

@interface SafetyPlanManager : NSObject

-(WarningSign*) warningSignAtIndex:(int) index;
-(void) saveWarningSign:(WarningSign*) warningSign atIndex:(int) index;

+(SafetyPlanManager*) sharedManager;

@end
