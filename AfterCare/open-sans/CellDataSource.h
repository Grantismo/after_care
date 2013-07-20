//
//  CellDataSource.h
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CellDataSource <NSObject>
- (void) onDidSelectCell;
- (UITableViewCell *) UITableViewCell;

@end
