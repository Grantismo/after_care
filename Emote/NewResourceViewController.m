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

#import <QuartzCore/QuartzCore.h>


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
    
    BOOL killed;
    
    CAShapeLayer* firstCellLayer;
    CAShapeLayer* lastCellLayer;
}

-(IBAction) done: (id) sender;
-(IBAction) cancel: (id) sender;
- (NSString* ) currentResourceType;

- (NSString*) displayFieldAtIndexPath: (NSIndexPath*) indexPath;

- (NSArray*) currentfields;

-(IBAction)toggleChanged:(UISegmentedControl*)sender;

-(void) keyboardUp:(NSNotification*) notification;
-(void) keyboardDown:(NSNotification*) notification;

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
    
    
    UIBezierPath *roundedUpper = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0, 0.0, 302.0, 45.0) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(8.0f, 8.0f)];
    
    firstCellLayer = [[CAShapeLayer alloc] init];
    [firstCellLayer setPath:roundedUpper.CGPath];
    
    firstCellLayer.borderWidth = .5;
    firstCellLayer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIBezierPath *roundedLower = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0, 0.0, 302.0, 43.0) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(8.0f, 8.0f)];
    
    lastCellLayer = [[CAShapeLayer alloc] init];
    [lastCellLayer setPath:roundedLower.CGPath];
    
    lastCellLayer.borderWidth = .5;
    lastCellLayer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [newResourceTableView reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUp:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDown:) name:UIKeyboardWillHideNotification object:nil];
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
            
            cell.selectedBackgroundView = [[UIView alloc] init];
            cell.selectedBackgroundView.backgroundColor = self.backgroundColor;
        }
        
        if ([emotionIsSelected[indexPath.row] boolValue]){
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else{
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
        
        if (indexPath.row == 0){
            cell.selectedBackgroundView.layer.mask = firstCellLayer;
        }
        else if (indexPath.row == emotions.count - 1){
            cell.selectedBackgroundView.layer.mask = lastCellLayer;
        }
        else cell.selectedBackgroundView.layer.mask = nil;
        
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

-(BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 2;
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
    killed = TRUE;
    
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

-(void) keyboardUp:(NSNotification *)notification{
    CGRect keyboardFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        newResourceTableView.frame = CGRectMake(0.0,
                                                0.0,
                                                newResourceTableView.frame.size.width,
                                                keyboardFrame.origin.y - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height);
    }];
    
    [newResourceTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void) keyboardDown:(NSNotification *)notification{
    NSTimeInterval duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        newResourceTableView.frame = CGRectMake(0.0,
                                                newResourceTableView.frame.origin.y,
                                                newResourceTableView.frame.size.width,
                                                newResourceTableView.frame.size.height - self.navigationController.navigationBar.frame.size.height);
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (!killed){
        NSIndexPath* path = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        NSString* field =  [displayNameToField objectForKey:[self displayFieldAtIndexPath:path]];
        
        NSMutableSet * selectedEmotions = [[NSMutableSet alloc] init];
        
        for(int i = 0; i < emotions.count; i++){
            if([emotionIsSelected[i] boolValue]){
                [selectedEmotions addObject:emotions[i]];
            }
        }
        
        int randomImageNum = (arc4random() % 5) + 1;
        NSString* imagePath = [NSString stringWithFormat:@"default_image_%d", randomImageNum];
        self.resource.emotions = selectedEmotions;
        [self.resource setValue:imagePath forKey:@"imageUrl"];
        [self.resource setValue:textField.text forKey:field]; 
    }
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
