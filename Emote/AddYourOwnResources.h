//
//  AddYourOwnResourcesTableView.h
//  Emote
//
//  Created by Grant Warman on 8/8/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellDataProvider.h"

@interface AddYourOwnResources : NSObject<CellDataProvider>

-(UITableViewCell*) newUITableViewCell;
-(void) onDidSelectCell;
-(CGFloat) cellHeight;
-(void) bindToUITableViewCell: (UITableViewCell *) cell;

@property (nonatomic, strong) NSString* reuseIdentifier;
@property (nonatomic, weak) id<CellActionDelegate> delegate;
@property (nonatomic, strong) UIColor* color;
@property CGFloat staticCellHeight;

@end
