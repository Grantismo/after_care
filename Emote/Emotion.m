//
//  AfterCare.m
//  AfterCare
//
//  Created by Grant Warman on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "Emotion.h"
#import <CoreData/CoreData.h>

@implementation Emotion

@dynamic name;
@dynamic resources;
@dynamic color;
@dynamic emotionDescription;

+ (NSArray*) fetchWithNames: (NSString*) names fromManagedObjectContext: (NSManagedObjectContext*) context{
    
    NSMutableArray* emotionNames = [[names componentsSeparatedByString: @"/"] mutableCopy];

    NSFetchRequest* request = [self fetchRequest:context];

    if( [(NSString*)emotionNames[0] isEqualToString:@"ALL"]){
        return [context executeFetchRequest:request error:nil];
    }
    
    
    NSCharacterSet *charactersToRemove =
    [[ NSCharacterSet alphanumericCharacterSet ] invertedSet ];
    
    for(int i = 0; i < emotionNames.count; i++){
        NSString *trimmedReplacement =
        [[[emotionNames objectAtIndex:i] componentsSeparatedByCharactersInSet: charactersToRemove]
         componentsJoinedByString:@""].lowercaseString;
        
        [emotionNames replaceObjectAtIndex:i withObject:trimmedReplacement];
    }
    

    
    
    request.predicate = [NSPredicate predicateWithFormat:@"name IN [c] %@",
                              emotionNames, nil];
    return [context executeFetchRequest:request error:nil];
}



@end

@interface ColorToDataTransformer : NSObject

+ (BOOL)allowsReverseTransformation;
+ (Class)transformedValueClass;
- (id)transformedValue:(id)value;
- (id)reverseTransformedValue:(id)value;

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