//
//  AfterCare.m
//  AfterCare
//
//  Created by Grant Warman on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "Emotion.h"


@implementation Emotion
@dynamic name;
@dynamic resources;
@dynamic color;
@end

@implementation ColorToDataTransformer : NSObject 

+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSData class];
}


- (id)transformedValue:(id)value {
    UIColor *color = (UIColor *)value;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:color];
    return data;
}

- (id)reverseTransformedValue:(id)value {
    NSData *data = (NSData *)value;
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return color;
}

@end