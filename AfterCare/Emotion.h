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

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) UIColor *color;

@property (nonatomic, retain) NSSet *resources;

+ (NSArray*) fetchWithNames: (NSString*) names fromManagedObjectContext: (NSManagedObjectContext*) context;
@end
