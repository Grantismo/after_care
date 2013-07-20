//
//  CellDataSource.m
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "CellFactory.h"

@implementation CellFactory

+(UITableViewCell *)UITableViewCellFromDataSource:(id<CellDataProvider>)provider tableView:(UITableView *)tableView{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:provider.reuseIdentifier];
    if (cell == nil) {
        cell = [provider newUITableViewCell];
    }
    
    [provider bindToUITableViewCell: cell];
    NSLog(@"%@", cell);

    return cell;
}

+(UITableViewCell *)UITableViewCellFromNibNamed:(NSString *)nibName{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] objectAtIndex:0];
}

@end
