//
//  CellDataSource.h
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellDataProvider.h"




@interface CellFactory: NSObject
+(UITableViewCell*) UITableViewCellFromDataSource: (id<CellDataProvider>) provider tableView: (UITableView*) tableView;
+(UITableViewCell*) UITableViewCellFromNibNamed:(NSString*) nibName;

@end
