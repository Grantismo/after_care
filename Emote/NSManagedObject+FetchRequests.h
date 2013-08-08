//
//  NSManagedObject+FetchRequests.h
//  AfterCare
//
//  Created by Grant Warman on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (FetchRequests)

+(NSFetchRequest*) fetchRequest:(NSManagedObjectContext*) context;

@end
