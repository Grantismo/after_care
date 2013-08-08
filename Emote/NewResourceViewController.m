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
#import "PhoneNumber.h"
#import "TextFieldCell.h"

@interface NewResourceViewController ()<UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UIButton* doneButton;
    IBOutlet UIButton* cancelButton;
    
    IBOutlet UITableView* newResourceTableView;
    
    IBOutlet UITableViewCell* toggleCell;
    IBOutlet UISegmentedControl* toggle;
    NSDictionary *displayNameToField;

}

-(IBAction) done: (id) sender;
-(IBAction) cancel: (id) sender;
- (NSString* ) currentResourceType;

- (NSString*) displayFieldAtIndexPath: (NSIndexPath*) indexPath;

- (NSArray*) currentfields;

-(IBAction)toggleChanged:(UISegmentedControl*)sender;
@end

@implementation NewResourceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton ];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    
    
    displayNameToField = @{@"url": @"url", @"title": @"title", @"description": @"descript", @"number": @"number", @"name": @"name"};

    
    self.fields = @{@"Website":
                        @[@"url", @"title", @"description"],
                    @"PhoneNumber":
                        @[@"number", @"name", @"description"]
                    };

    
    self.resource = (Website*)[NSEntityDescription
                                  insertNewObjectForEntityForName:@"Website"
                                  inManagedObjectContext:self.managedObjectContext];
    
    [cancelButton setImage:[[cancelButton imageForState:UIControlStateNormal] resizableImageWithCapInsets:UIEdgeInsetsMake(14.0, 14.0, 14.0, 14.0)] forState:UIControlStateNormal];
    
    [doneButton setImage:[[doneButton imageForState:UIControlStateNormal] resizableImageWithCapInsets:UIEdgeInsetsMake(14.0, 14.0, 14.0, 14.0)] forState:UIControlStateNormal];
    

    [[StyleManager sharedStyleManager] setBoldFontForLabel:cancelButton.titleLabel];
    [[StyleManager sharedStyleManager] setBoldFontForLabel:doneButton.titleLabel];
    
     newResourceTableView.backgroundView = nil;
    
    UIFont *font = [UIFont fontWithName:OPEN_SANS_BOLD size:12.0];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [toggle setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImageCreator onePixelImageForColor:self.backgroundColor] forBarMetrics:UIBarMetricsDefault];
    
    newResourceTableView.backgroundColor = [UIColor addBrightness:self.backgroundColor amount:.3];
    
    toggle.tintColor = self.backgroundColor;
}

- (NSString* ) currentResourceType{
    return @[@"Website", @"PhoneNumber"][toggle.selectedSegmentIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return ((NSDictionary*) self.fields[[self currentResourceType]]).count;
    }
    else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        static NSString *CellIdentifier = @"Cell";
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.textLabel.text = [self displayFieldAtIndexPath:indexPath];
        cell.textField.tag = indexPath.row;
        cell.textField.delegate = self;
        cell.textField.textColor = [UIColor blackColor];

        
        
        return cell;
    }
    else return toggleCell;
    
}

- (NSArray*) currentfields{
    return (NSArray*) self.fields[[self currentResourceType]];
}

- (NSString*) displayFieldAtIndexPath: (NSIndexPath*) indexPath{
    return [[self currentfields] objectAtIndex:indexPath.row];
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 44;
    else return toggleCell.frame.size.height;
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [[StyleManager sharedStyleManager] setBoldFontForLabel:cell.textLabel];
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
    [self.managedObjectContext deleteObject:self.resource];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)done:(id)sender{
    
    [self.managedObjectContext save:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)toggleChanged:(UISegmentedControl *)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.managedObjectContext deleteObject:self.resource];
            self.resource = (Website*)[NSEntityDescription
                                       insertNewObjectForEntityForName:@"Website"
                                       inManagedObjectContext:self.managedObjectContext];
            [newResourceTableView reloadData];
            break;
        case 1:
            [self.managedObjectContext deleteObject:self.resource];
            self.resource = (PhoneNumber*)[NSEntityDescription
                                       insertNewObjectForEntityForName:@"PhoneNumber"
                                       inManagedObjectContext:self.managedObjectContext];
            [newResourceTableView reloadData];

            break;
            
        default:
            break;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSIndexPath* path = [NSIndexPath indexPathForRow:textField.tag inSection:0];
    NSString* field =  [displayNameToField objectForKey:[self displayFieldAtIndexPath:path]];
    [self.resource setValue:textField.text forKey:field];
}

@end
