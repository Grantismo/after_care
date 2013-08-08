//
//  NSManagedObject+FetchRequests.m
//  AfterCare
//
//  Created by Grant Warman on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "NSManagedObject+FetchRequests.h"

@implementation NSManagedObject (FetchRequests)

+(NSFetchRequest*) fetchRequest:(NSManagedObjectContext*) context{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    [request setEntity:entity];
    return request;
}

@end
