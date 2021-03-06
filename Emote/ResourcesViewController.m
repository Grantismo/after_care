//
//  ResourcesViewController.m
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "ResourcesViewController.h"
#import "Website.h"
#import "CellFactory.h"
#import "PhoneNumber.h"
#import "NewResourceViewController.h"
#import "UIImageCreator.h"

#import <QuartzCore/QuartzCore.h>
#import "StyleManager.h"

#import "AddYourOwnResources.h"

@interface ResourcesViewController (){
    IBOutlet UIView* navBarFooterContentView;
    IBOutlet UIImageView* navBarFooterImageView;
    
    IBOutlet UILabel* emotionLabel;
    
    IBOutlet UIButton* backButton;
    
    IBOutlet UILabel* titleLabel;
    
    NSIndexPath* selectedIndexPath;
}

-(IBAction)popSelf:(id)sender;

@end

@implementation ResourcesViewController

- (id) initWithEmotion: (Emotion *) emotion{
    if(self = [super initWithNibName: NSStringFromClass([ResourcesViewController class]) bundle: nil]){        
        self.emotion = emotion;
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    titleLabel.text = [NSString stringWithFormat:@"I'm Feeling %@", self.emotion.name.capitalizedString];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    
    navBarFooterImageView.image = [UIImageCreator arrowImageWithSize:navBarFooterImageView.frame.size andArrowSize:CGSizeMake(20.0, 8.0) andArrowWidthRatio:.5 andColor:self.emotion.color];
    
    navBarFooterImageView.layer.shadowOffset = CGSizeMake(0.0, 3.0);
    navBarFooterImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    navBarFooterImageView.layer.shadowRadius = 2.0;
    navBarFooterImageView.layer.shadowOpacity = .5;
    
    emotionLabel.textColor = [UIColor changeBrightness:self.emotion.color amount:.55];
    
    [[StyleManager sharedStyleManager] setBoldFontForLabel:backButton.titleLabel];
    
    //Move out of the way of safety plan nav controller whose navigation bar is the same height as this one.
    self.tableView.frame = CGRectMake(0.0,
                                      self.tableView.frame.origin.y,
                                      self.tableView.frame.size.width,
                                      self.tableView.frame.size.height - self.navigationController.navigationBar.frame.size.height);
    
    [self fetchResources];

}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
     emotionLabel.text = self.emotion.emotionDescription;
    [self fetchResources];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImageCreator onePixelImageForColor:self.emotion.color] forBarMetrics:UIBarMetricsDefault];
    
    if (selectedIndexPath){
        [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:FALSE];
    }
}

-(void) fetchResources{
    NSMutableArray* resources = [NSMutableArray arrayWithArray:[self.emotion.resources allObjects]];
    [resources addObject: [[AddYourOwnResources alloc] init]];
    
    NSArray* colorChoices = [UIColor complementingColors:self.emotion.color];

    for(int i = 0; i < resources.count; i++){
        [[resources objectAtIndex:i] setValue:[colorChoices objectAtIndex:(i % colorChoices.count)]forKey:@"color"];
        
        [[resources objectAtIndex:i] setValue:self forKey:@"delegate"];
    }
    self.dataSources = resources;

}
- (id<CellDataProvider>) cellDataSourceForRowAtIndexPath:(NSIndexPath*) indexPath{
    return [self.dataSources objectAtIndex:indexPath.row];
}

#pragma mark - Table view data source

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self cellDataSourceForRowAtIndexPath:indexPath] cellHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return [CellFactory UITableViewCellFromDataSource:[self cellDataSourceForRowAtIndexPath:indexPath] tableView:tableView];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[self cellDataSourceForRowAtIndexPath:indexPath] onDidSelectCell];
    
    selectedIndexPath = indexPath;
}

- (void) pushUIViewController: (UIViewController *)controller{
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark Actions


-(IBAction)popSelf:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
