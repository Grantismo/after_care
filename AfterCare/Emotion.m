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

+ (NSArray*) fetchWithNames: (NSString*) names fromManagedObjectContext: (NSManagedObjectContext*) context{
    
    NSCharacterSet *charactersToRemove =
    [[ NSCharacterSet alphanumericCharacterSet ] invertedSet ];
    
    
    
    NSMutableArray* emotionNames = [[names componentsSeparatedByString: @"/"] mutableCopy];
    
    for(int i = 0; i < emotionNames.count; i++){
        NSString *trimmedReplacement =
        [[[emotionNames objectAtIndex:i] componentsSeparatedByCharactersInSet: charactersToRemove]
         componentsJoinedByString:@""].lowercaseString;
        
        [emotionNames replaceObjectAtIndex:i withObject:trimmedReplacement];
    }
    
    NSLog(@"emotions: %@ ", emotionNames);
    NSFetchRequest* request = [self fetchRequest:context];

    if( [(NSString*)emotionNames[0] isEqualToString:@"ALL"]){
        return [context executeFetchRequest:request error:nil];
    }
    
    request.predicate = [NSPredicate predicateWithFormat:@"name IN [c] %@",
                              emotionNames, nil];
    return [context executeFetchRequest:request error:nil];
}



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

+ (NSArray*) fetchWithNames: (NSString*) names {
    
}
@end