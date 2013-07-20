//
//  CellDataProviderBase.h
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellActionDelegate.h"
#import <CoreData/CoreData.h>

@interface CellDataProviderBase : NSManagedObject
-(UITableViewCell*) newUITableViewCell;

@property (nonatomic, strong) NSString* reuseIdentifier;
@property (nonatomic, weak) id<CellActionDelegate> delegate;
@property CGFloat staticCellHeight;

-(CGFloat)cellHeight;

@end
