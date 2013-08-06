//
//  SafetyPlan.m
//  AfterCare
//
//  Created by Grant Warman on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlan.h"

@implementation SafetyPlan

#define kWarningSign1Key @"warningSign1"
#define kWarningSign2Key @"warningSign2"
#define kWarningSign3Key @"warningSign3"
#define kCopingStrategy1Key @"copingStrategy1"
#define kCopingStrategy2Key @"copingStrategy2"
#define kCopingStrategy3Key @"copingStrategy3"
#define kPlace1Key @"place1"
#define kPlace2Key @"place2"
#define kPlace3Key @"place3"
#define kPerson1Key @"person1"
#define kPerson2Key @"person2"
#define kPerson3Key @"person3"
#define kProfessional1Key @"professional1"
#define kProfessional2Key @"professional2"
#define kProfessional3Key @"professional3"
#define kEnvironment1Key @"environment1"
#define kEnvironment2Key @"environment2"


- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject: self.warningSign1 forKey:kWarningSign1Key];
    [encoder encodeObject: self.warningSign2 forKey:kWarningSign2Key];
    [encoder encodeObject: self.warningSign3 forKey:kWarningSign3Key];
    [encoder encodeObject: self.copingStrategy1 forKey:kCopingStrategy1Key];
    [encoder encodeObject: self.copingStrategy2 forKey:kCopingStrategy2Key];
    [encoder encodeObject: self.copingStrategy3 forKey:kCopingStrategy3Key];
    [encoder encodeObject: self.place1 forKey:kPlace1Key];
    [encoder encodeObject: self.place2 forKey:kPlace2Key];
    [encoder encodeObject: self.place3 forKey:kPlace3Key];
    [encoder encodeObject: self.person1 forKey:kPerson1Key];
    [encoder encodeObject: self.person2 forKey:kPerson2Key];
    [encoder encodeObject: self.person3 forKey:kPerson3Key];
    [encoder encodeObject: self.professional1 forKey:kProfessional1Key];
    [encoder encodeObject: self.professional2 forKey:kProfessional2Key];
    [encoder encodeObject: self.professional3 forKey:kProfessional3Key];
    [encoder encodeObject: self.environment1 forKey:kEnvironment1Key];
    [encoder encodeObject: self.environment2 forKey:kEnvironment2Key];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self){
        self.warningSign1 = [decoder decodeObjectForKey:kWarningSign1Key];
        self.warningSign2 = [decoder decodeObjectForKey:kWarningSign2Key];
        self.warningSign3 = [decoder decodeObjectForKey:kWarningSign3Key];
        self.copingStrategy1 = [decoder decodeObjectForKey:kCopingStrategy1Key];
        self.copingStrategy2 = [decoder decodeObjectForKey:kCopingStrategy2Key];
        self.copingStrategy3 = [decoder decodeObjectForKey:kCopingStrategy3Key];
        self.place1 = [decoder decodeObjectForKey:kPlace1Key];
        self.place2 = [decoder decodeObjectForKey:kPlace2Key];
        self.place3 = [decoder decodeObjectForKey:kPlace3Key];
        self.person1 = [decoder decodeObjectForKey:kPerson1Key];
        self.person2 = [decoder decodeObjectForKey:kPerson2Key];
        self.person3 = [decoder decodeObjectForKey:kPerson3Key];
        self.professional1 = [decoder decodeObjectForKey:kProfessional1Key];
        self.professional2 = [decoder decodeObjectForKey:kProfessional2Key];
        self.professional3 = [decoder decodeObjectForKey:kProfessional3Key];
        self.environment1 = [decoder decodeObjectForKey:kEnvironment1Key];
        self.environment2 = [decoder decodeObjectForKey:kEnvironment2Key];
    }
    return self;
}


@end