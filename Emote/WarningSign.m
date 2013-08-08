//
//  SafetyPlanWarningSign.m
//  AfterCare
//
//  Created by Lucas Best on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "WarningSign.h"

#define kWarningSignKey @"warningSign"

@implementation WarningSign

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        self.warningSign = [aDecoder decodeObjectForKey:kWarningSignKey];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.warningSign forKey:kWarningSignKey];
}

@end
