//
//  NewResourceViewController.h
//  AfterCare
//
//  Created by Grant Warman on 7/21/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Website.h"

@interface NewResourceViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) Website *website;
@property (nonatomic, strong) NSArray *fields;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


-(IBAction) done: (id) sender;
-(IBAction) cancel: (id) sender;

@end
