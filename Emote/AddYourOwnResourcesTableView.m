//
//  AddYourOwnResourcesTableView.m
//  Emote
//
//  Created by Grant Warman on 8/8/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "AddYourOwnResourcesTableView.h"
#import "CellFactory.h"
#import "NewResourceViewController.h"
#import "AddYourOwnResourcesTableViewCell.h"

@implementation AddYourOwnResourcesTableView

- (id)init
{
    self = [super init];
    if (self) {
        self.reuseIdentifier = @"AddYourOwnResourcesTableViewCell";
        self.staticCellHeight = [self newUITableViewCell].frame.size.height;

    }
    return self;
}

-(UITableViewCell*) newUITableViewCell{
    return [CellFactory UITableViewCellFromNibNamed:self.reuseIdentifier];
}

-(CGFloat)cellHeight{
    return self.staticCellHeight;
}


-(void) onDidSelectCell{
    NewResourceViewController *controller = [[NewResourceViewController alloc] init];

    [self.delegate pushUIViewController:controller];
}


-(void) bindToUITableViewCell: (UITableViewCell *) cell{
    AddYourOwnResourcesTableViewCell* addCell = (AddYourOwnResourcesTableViewCell*) cell;

    addCell.informationContentView.backgroundColor = self.color;
    addCell.descriptionLabel.textColor = [UIColor changeBrightness:self.color amount:0.65];
}

@end
