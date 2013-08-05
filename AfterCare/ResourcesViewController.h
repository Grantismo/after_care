//
//  ResourcesViewController.h
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellActionDelegate.h"

@interface ResourcesViewController : UIViewController<CellActionDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray* dataSources;
- (id) initWithNSManagedObjectContext: (NSManagedObjectContext *) context;
@property (nonatomic, strong) IBOutlet UITableView * tableView;
@end
