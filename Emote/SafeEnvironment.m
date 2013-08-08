//
//  SafeEnvironment.m
//  AfterCare
//
//  Created by Lucas Best on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafeEnvironment.h"

#define kSafeEnvironmentKey @"safeEnvironment"

@implementation SafeEnvironment

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        self.safeEnvironment = [aDecoder decodeObjectForKey:kSafeEnvironmentKey];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.safeEnvironment forKey:kSafeEnvironmentKey];
}

@end
