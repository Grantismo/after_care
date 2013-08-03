//
//  SafetyPlanViewController.m
//  AfterCare
//
//  Created by Lucas Best on 8/2/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanViewController.h"
#import "UIImageCreator.h"

@interface SafetyPlanViewController (){
    IBOutlet UIButton* backButton;
}

-(IBAction) dismiss:(id) sender;

@end

@implementation SafetyPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Setup my safety plan";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImageCreator onePixelImageForColor:[UIColor afterCareOffWhiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem* barItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barItem;
    
     backButton.alpha = 0.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Actions

-(IBAction)dismiss:(id)sender{
    [UIView animateWithDuration:.2 animations:^{
        backButton.alpha = 0.0;
    } completion:^(BOOL finished) {
         [self.delegate dismissSafetyPlayController:self];
    }];
}

#pragma mark public methods

-(void) addBackButton{
    [UIView animateWithDuration:.4 animations:^{
        backButton.alpha = 1.0;
    }];
}

#pragma mark private methods



@end
