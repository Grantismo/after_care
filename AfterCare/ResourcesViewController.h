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

- (id) initWithNSManagedObjectContext: (NSManagedObjectContext *) context andColor:(UIColor*) color;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray* dataSources;
@property (nonatomic, strong) IBOutlet UITableView * tableView;

@property (nonatomic, strong) UIColor* color;
@end
