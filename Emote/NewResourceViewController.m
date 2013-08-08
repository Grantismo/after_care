//
//  NewResourceViewController.m
//  AfterCare
//
//  Created by Grant Warman on 7/21/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "NewResourceViewController.h"
#import <CoreData/CoreData.h>
#import "Website.h"

#import "UIImageCreator.h"
#import "StyleManager.h"

@interface NewResourceViewController (){
    IBOutlet UIButton* doneButton;
    IBOutlet UIButton* cancelButton;
    
    IBOutlet UITableView* newResourceTableView;
}

-(IBAction) done: (id) sender;
-(IBAction) cancel: (id) sender;
@end

@implementation NewResourceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton ];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    
    NSDictionary *fields = @{@"Website": @{@"Url: ": @"url", @"Title: ": @"title", @"Description: ": @"descript"}, @"PhoneNumber": @{@"Number: ": @"number", @"Name: ": @"name", @"Description: ": @"descript"}};
    NSMutableArray* mutableFields = [[NSMutableArray alloc] init];


    self.fields = mutableFields;
    self.website = (Website*)[NSEntityDescription
                                  insertNewObjectForEntityForName:@"Website"
                                  inManagedObjectContext:self.managedObjectContext];
    
    [cancelButton setImage:[[cancelButton imageForState:UIControlStateNormal] resizableImageWithCapInsets:UIEdgeInsetsMake(14.0, 14.0, 14.0, 14.0)] forState:UIControlStateNormal];
    
    [doneButton setImage:[[doneButton imageForState:UIControlStateNormal] resizableImageWithCapInsets:UIEdgeInsetsMake(14.0, 14.0, 14.0, 14.0)] forState:UIControlStateNormal];
    

    [[StyleManager sharedStyleManager] setBoldFontForLabel:cancelButton.titleLabel];
    [[StyleManager sharedStyleManager] setBoldFontForLabel:doneButton.titleLabel];
    
     newResourceTableView.backgroundView = nil;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImageCreator onePixelImageForColor:self.backgroundColor] forBarMetrics:UIBarMetricsDefault];
    
    newResourceTableView.backgroundColor = [UIColor addBrightness:self.backgroundColor amount:.3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = [self fieldAtIndexPath:indexPath];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        textField.adjustsFontSizeToFitWidth = YES;
        textField.textColor = [UIColor blackColor];
        [textField setEnabled:YES];
        textField.tag = indexPath.row;
        textField.delegate = self;
        [cell.contentView addSubview:textField];

    }
    
    return cell;
}

- (NSString*) fieldAtIndexPath: (NSIndexPath *) indexPath{
    return [self.fields objectAtIndex:indexPath.row];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(IBAction)cancel:(id)sender{
    [self.managedObjectContext deleteObject:self.website];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)done:(id)sender{
    
    [self.managedObjectContext save:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString* field = [self.fields objectAtIndex:textField.tag];
    [self.website setValue:textField.text forKey:field];
}

@end
