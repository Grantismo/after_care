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
#import "Emotion.h"
#include <stdlib.h>


#import "Emotion.h"

@interface NewResourceViewController ()<UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UIButton* doneButton;
    IBOutlet UIButton* cancelButton;
    
    IBOutlet UITableView* newResourceTableView;
    
    IBOutlet UITableViewCell* toggleCell;
    IBOutlet UISegmentedControl* toggle;
    NSDictionary *displayNameToField;

    
    NSArray* emotions;
    
    NSMutableArray* emotionIsSelected;
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
    
    self.title = @"New Resource";
    
    emotions = [self.managedObjectContext executeFetchRequest:[Emotion fetchRequest: self.managedObjectContext] error:nil];
    
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
    
    newResourceTableView.frame = CGRectMake(0.0,
                                      newResourceTableView.frame.origin.y,
                                      newResourceTableView.frame.size.width,
                                      newResourceTableView.frame.size.height - self.navigationController.navigationBar.frame.size.height);
    
    emotionIsSelected = [[NSMutableArray alloc] initWithObjects:@YES, @YES, @YES, @YES, @YES, @YES, @YES, @YES, nil];
    
    
    
    for (int i = 0; i < emotions.count; i++) {
        NSIndexPath* path = [NSIndexPath indexPathForRow:i inSection:2];
        [newResourceTableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    [newResourceTableView reloadData];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 1;
    else if (section == 1){
        return ((NSDictionary*) self.fields[[self currentResourceType]]).count;
    }
    else return emotions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) return toggleCell;
    else if (indexPath.section == 1){
        static NSString *CellIdentifier = @"Cell";
        TextFieldCell *cell = (TextFieldCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.inputTextField.delegate = self;
            
            cell.textLabel.backgroundColor = [UIColor clearColor];
        }
        
        cell.textLabel.text = [self displayFieldAtIndexPath:indexPath];
        cell.inputTextField.tag = indexPath.row;
        
        if ([[self displayFieldAtIndexPath:indexPath] isEqualToString:@"url"]) {
            cell.inputTextField.keyboardType = UIKeyboardTypeURL;
            cell.inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        }
        else{
            cell.inputTextField.keyboardType = UIKeyboardTypeDefault;
            cell.inputTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        }
        
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"EmotionCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        Emotion* emotion = emotions[indexPath.row];
        
        cell.textLabel.text = emotion.name;
        
        cell.accessoryType = [[emotionIsSelected objectAtIndex:indexPath.row] boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        
        return cell;
    }
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return @"Type:";
    }
    else if (section == 1){
        return @"Fields:";
    }
    else return @"Emotions:";
}

- (NSArray*) currentfields{
    return (NSArray*) self.fields[[self currentResourceType]];
}

- (NSString*) displayFieldAtIndexPath: (NSIndexPath*) indexPath{
    return [[self currentfields] objectAtIndex:indexPath.row];
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return toggleCell.frame.size.height;
    else return 44.0;
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [[StyleManager sharedStyleManager] setBoldFontForLabel:cell.textLabel];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2){
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
         cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        [emotionIsSelected replaceObjectAtIndex:indexPath.row withObject:@YES];
    }
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2){
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        [emotionIsSelected replaceObjectAtIndex:indexPath.row withObject:@NO];
    }
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
    self.resource.emotions = [NSSet setWithArray:[Emotion fetchWithNames: @"ALL" fromManagedObjectContext:self.managedObjectContext]];
    int randomImageNum = (arc4random() % 5) + 1;
    NSString* imagePath = [NSString stringWithFormat:@"default_image_%d", randomImageNum];
    [self.resource setValue:imagePath forKey:@"imageUrl"];
    [self.resource setValue:textField.text forKey:field];
}

@end
