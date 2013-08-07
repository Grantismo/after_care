//
//  Professional.m
//  AfterCare
//
//  Created by Lucas Best on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "Professional.h"

#define kNameKey @"name"
#define kPhoneNumberKey @"phoneNumber"

@implementation Professional

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        self.name = [aDecoder decodeObjectForKey:kNameKey];
        self.phoneNumber = [aDecoder decodeObjectForKey:kPhoneNumberKey];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeObject:self.phoneNumber forKey:kPhoneNumberKey];
}

@end
