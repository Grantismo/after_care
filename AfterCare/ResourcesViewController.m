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

@interface ResourcesViewController (){
    IBOutlet UIView* navBarFooterContentView;
    IBOutlet UIImageView* navBarFooterImageView;
    
    IBOutlet UIButton* backButton;
}

-(IBAction)popSelf:(id)sender;

@end

@implementation ResourcesViewController

- (id) initWithEmotion: (Emotion *) emotion{
    if(self = [super initWithNibName: NSStringFromClass([ResourcesViewController class]) bundle: nil]){        
        self.emotion = emotion;
        self.title = [NSString stringWithFormat:@"I'm Feeling %@", emotion.name.capitalizedString];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIColor* color = self.emotion.color;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImageCreator onePixelImageForColor:color] forBarMetrics:UIBarMetricsDefault];

    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    navBarFooterImageView.image = [UIImageCreator arrowImageWithSize:navBarFooterImageView.frame.size andArrowSize:CGSizeMake(20.0, 8.0) andArrowWidthRatio:.5 andColor:color];
    
    navBarFooterImageView.layer.shadowOffset = CGSizeMake(0.0, 3.0);
    navBarFooterImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    navBarFooterImageView.layer.shadowRadius = 2.0;
    navBarFooterImageView.layer.shadowOpacity = .5;
    
    [[StyleManager sharedStyleManager] setBoldFontForLabel:backButton.titleLabel];
    
//    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addResource:)];
// 
//    self.navigationItem.rightBarButtonItem = button;
    
//    PhoneNumber* number = (PhoneNumber*)[NSEntityDescription
//                              insertNewObjectForEntityForName:@"PhoneNumber"
//                              inManagedObjectContext:self.managedObjectContext];
//    number.name = @"SUICIDE ANONYMOUS";
//    number.number = @"2486223655";
//    number.descript = @"Suicideanonymous.net is a website that provides resources that provide worldwide Skype meetings and other support systems.";
//    number.color = [UIColor depressedColor];

    
        
    [self fetchResources];

}

-(void) fetchResources{
    self.dataSources = [self.emotion.resources allObjects];
    NSArray* colorChoices = [UIColor complementingColors:self.emotion.color];

    for(int i = 0; i < self.dataSources.count; i++){
        [[self.dataSources objectAtIndex:i] setValue:[colorChoices objectAtIndex:(i % colorChoices.count)]forKey:@"color"];
    }

}
- (id<CellDataProvider>) cellDataSourceForRowAtIndexPath:(NSIndexPath*) indexPath{
    return [self.dataSources objectAtIndex:indexPath.row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self cellDataSourceForRowAtIndexPath:indexPath] onDidSelectCell];
}

- (void) pushUIViewController: (UIViewController *)controller{
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark Actions

-(IBAction) addResource:(id)sender{
    NewResourceViewController *controller = [[NewResourceViewController alloc] init];
    
    [self presentViewController:controller animated:YES completion:^{
        [self fetchResources];
        [self.tableView reloadData];
    }];
}

-(IBAction)popSelf:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
