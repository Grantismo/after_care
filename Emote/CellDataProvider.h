//
//  CellDataProvider.h
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellActionDelegate.h"
#import "CellDataProvider.h"

@protocol CellDataProvider <NSObject>
-(UITableViewCell*) newUITableViewCell;
-(void) onDidSelectCell;
-(CGFloat) cellHeight;
-(void) bindToUITableViewCell: (UITableViewCell *) cell;

@property (nonatomic, strong) NSString* reuseIdentifier;
@property (nonatomic, weak) id<CellActionDelegate> delegate;
@end
