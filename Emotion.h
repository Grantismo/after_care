//
//  AfterCare.h
//  AfterCare
//
//  Created by Grant Warman on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CellDataProviderBase;

@interface AfterCare : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *resources;
@end

@interface  (CoreDataGeneratedAccessors)

- (void)addResourcesObject:(CellDataProviderBase *)value;
- (void)removeResourcesObject:(CellDataProviderBase *)value;
- (void)addResources:(NSSet *)values;
- (void)removeResources:(NSSet *)values;

@end
