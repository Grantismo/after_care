//
//  AfterCare.h
//  AfterCare
//
//  Created by Grant Warman on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSManagedObject+FetchRequests.h"


@interface Emotion : NSManagedObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString* emotionDescription;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) NSSet *resources;

+ (NSArray*) fetchWithNames: (NSString*) names fromManagedObjectContext: (NSManagedObjectContext*) context;
@end
