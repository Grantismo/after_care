//
//  SafetyPlan.h
//  AfterCare
//
//  Created by Grant Warman on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "WarningSign.h"

@interface SafetyPlan : NSObject<NSCoding>

@property (nonatomic, strong) WarningSign* warningSign1;
@property (nonatomic, strong) WarningSign* warningSign2;
@property (nonatomic, strong) WarningSign* warningSign3;
@property (nonatomic, weak) NSString* copingStrategy1;
@property (nonatomic, weak) NSString* copingStrategy2;
@property (nonatomic, weak) NSString* copingStrategy3;
@property (nonatomic, weak) NSString* place1;
@property (nonatomic, weak) NSString* place2;
@property (nonatomic, weak) NSString* place3;
@property (nonatomic, weak) NSString* person1;
@property (nonatomic, weak) NSString* person2;
@property (nonatomic, weak) NSString* person3;
@property (nonatomic, weak) NSString* professional1;
@property (nonatomic, weak) NSString* professional2;
@property (nonatomic, weak) NSString* professional3;
@property (nonatomic, weak) NSString* environment1;
@property (nonatomic, weak) NSString* environment2;





@end
