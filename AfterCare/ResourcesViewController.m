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

@interface ResourcesViewController (){
    IBOutlet UIView* navBarFooterContentView;
    IBOutlet UIImageView* navBarFooterImageView;
}

@end

@implementation ResourcesViewController


- (id) initWithNSManagedObjectContext: (NSManagedObjectContext *) context{
    if(self = [super initWithNibName: NSStringFromClass([ResourcesViewController class]) bundle: nil]){
        self.managedObjectContext = context;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImageCreator onePixelImageForColor:[UIColor positiveColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"Resources";
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    navBarFooterImageView.image = [UIImageCreator arrowImageWithSize:navBarFooterImageView.frame.size andArrowSize:CGSizeMake(20.0, 8.0) andArrowWidthRatio:.5 andColor:[UIColor positiveColor]];
    
//    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addResource:)];
// 
//    self.navigationItem.rightBarButtonItem = button;
    
    PhoneNumber* number = (PhoneNumber*)[NSEntityDescription
                              insertNewObjectForEntityForName:@"PhoneNumber"
                              inManagedObjectContext:self.managedObjectContext];
    number.name = @"Grant";
    number.number = @"2486223655";
    number.descript = @"description goes here";
    number.color = [UIColor depressedColor];

    
    self.dataSources = [NSArray arrayWithObject:number];
    
    //[self fetchResources];
    
//    PhoneNumber* number = [[PhoneNumber alloc] init];

//    
//    [sources addObject:reddit];
//    [sources addObject:number];

    
 //   self.dataSources = sources;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) fetchResources{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Website" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    self.dataSources = [self.managedObjectContext executeFetchRequest:request error:nil];
    for(id<CellDataProvider> source in self.dataSources){
        source.delegate = self;
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

-(IBAction) addResource:(id)sender{
    NewResourceViewController *controller = [[NewResourceViewController alloc] init];
    controller.managedObjectContext = self.managedObjectContext;
    
    [self presentViewController:controller animated:YES completion:^{
        [self fetchResources];
        [self.tableView reloadData];
    }];
}

@end
