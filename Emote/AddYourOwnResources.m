//
//  AddYourOwnResourcesTableView.m
//  Emote
//
//  Created by Grant Warman on 8/8/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "AddYourOwnResources.h"
#import "CellFactory.h"
#import "NewResourceViewController.h"
#import "AddYourOwnResourcesCell.h"

@implementation AddYourOwnResources

- (id)init
{
    self = [super init];
    if (self) {
        self.reuseIdentifier = [NSStringFromClass(self.class) stringByAppendingString:@"Cell"];
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
    controller.managedObjectContext = self.delegate.managedObjectContext;

    [self.delegate pushUIViewController:controller];
}


-(void) bindToUITableViewCell: (UITableViewCell *) cell{
    AddYourOwnResourcesCell* addCell = (AddYourOwnResourcesCell*) cell;

    addCell.informationContentView.backgroundColor = self.color;
    addCell.descriptionLabel.textColor = [UIColor changeBrightness:self.color amount:0.65];
}

@end
