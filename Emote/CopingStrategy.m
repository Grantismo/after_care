//
//  CopingStrategy.m
//  AfterCare
//
//  Created by Lucas Best on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "CopingStrategy.h"

#define kCopingStrategyKey @"copingStrategy"

@implementation CopingStrategy

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        self.copingStrategy = [aDecoder decodeObjectForKey:kCopingStrategyKey];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.copingStrategy forKey:kCopingStrategyKey];
}

@end