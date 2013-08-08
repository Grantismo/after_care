//
//  NewResourceViewController.h
//  AfterCare
//
//  Created by Grant Warman on 7/21/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Website.h"
#import "CellDataProviderBase.h"

@interface NewResourceViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UIColor* backgroundColor;

@property (nonatomic, strong) CellDataProviderBase *resource;
@property (nonatomic, strong) NSDictionary *fields;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@end
