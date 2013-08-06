//
//  SafetyPlanViewController.m
//  AfterCare
//
//  Created by Lucas Best on 8/2/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanViewController.h"
#import "StyleManager.h"
#import "UIImageCreator.h"

#import "SafetyPlanWarningSignsScreen.h"

@interface SafetyPlanViewController (){
    IBOutlet UIButton* backButton;
    IBOutlet UIView* littleYellowArrowImageContainer;
    IBOutlet UIImageView* littleYellowArrowImage;
    
    IBOutlet UILabel* titleLabel;
    IBOutlet UILabel* descriptionLabel;
    
    IBOutlet UIView* contentView;
    
    IBOutlet UIButton* warningButton;
    IBOutlet UIButton* pencilButton;
    IBOutlet UIButton* treeButton;
    IBOutlet UIButton* personButton;
    IBOutlet UIButton* phoneButton;
    IBOutlet UIButton* houseButton;
    
    IBOutlet SafetyPlanWarningSignsScreen* warningSignScreen;
    
    NSArray* screens;
    int currentScreenIndex;
}

-(IBAction) dismiss:(id) sender;
-(IBAction)setContent:(UIButton*) sender;
-(SafetyPlanScreen*) currentScreen;

-(void) animateNewScreenAtIndex:(int) index;

-(void) setAllButtonesDeselected;

@end

@implementation SafetyPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Setup my safety plan.";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImageCreator onePixelImageForColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    [[StyleManager sharedStyleManager] appendTitleTextAttributes:@{UITextAttributeTextColor : [UIColor blackColor]} toNavigationBar:self.navigationController.navigationBar];
    
    UIBarButtonItem* barItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barItem;
    
    UIBarButtonItem* arrowItem = [[UIBarButtonItem alloc] initWithCustomView:littleYellowArrowImageContainer];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    flexibleSpace.width = 20.0;
    
    arrowItem.width = 40.0;
    
    self.navigationItem.rightBarButtonItem = arrowItem;
    
    backButton.alpha = 0.0;
    
    [[StyleManager sharedStyleManager] setBoldFontForLabel:backButton.titleLabel];
    [[StyleManager sharedStyleManager] setItalicFontForLabel:descriptionLabel];
    
    
    warningSignScreen.managedObjectContext = self.managedObjectContext;
    
    screens = @[warningSignScreen];
    
    currentScreenIndex = -1;
    [self setContent:warningButton];
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

-(IBAction)setContent:(UIButton *)sender{
    if (currentScreenIndex != sender.tag){
        currentScreenIndex = sender.tag;
        
        [self setAllButtonesDeselected];
        [self animateNewScreenAtIndex:sender.tag];
        
        [sender setSelected:TRUE];
    }
}

#pragma mark public methods

-(void) addBackButton{
    [UIView animateWithDuration:.4 animations:^{
        backButton.alpha = 1.0;
    }];
}

-(void) animateArrow:(BOOL)toSide withDuration:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration animations:^{
        littleYellowArrowImage.transform = toSide ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0.0);
    }];
}

#pragma mark private methods

-(void) animateNewScreenAtIndex:(int)index{
    SafetyPlanScreen* currentScreen = [self currentScreen];
    SafetyPlanScreen* targetScreen = [screens objectAtIndex:index];
    
    NSLog(@"%@ %@", currentScreen, targetScreen);
    
    [UIView animateWithDuration:.2 animations:^{
        titleLabel.alpha = 0.0;
        descriptionLabel.alpha = 0.0;
        
        [currentScreen animateOut];
    } completion:^(BOOL finished) {
        titleLabel.text = [targetScreen titleText];
        descriptionLabel.text = [targetScreen descriptionText];
        
        [currentScreen addToView:contentView];
        
        [UIView animateWithDuration:.2 animations:^{
            titleLabel.alpha = 1.0;
            
            [currentScreen animateIn];
        }];
        
        [UIView animateWithDuration:.4 animations:^{
            descriptionLabel.alpha = 1.0;
        }];
    }];
}

-(void) setAllButtonesDeselected{
    [warningButton setSelected:FALSE];
    [pencilButton setSelected:FALSE];
    [treeButton setSelected:FALSE];
    [personButton setSelected:FALSE];
    [phoneButton setSelected:FALSE];
    [houseButton setSelected:FALSE];
}

-(SafetyPlanScreen*) currentScreen{
    return [screens objectAtIndex:currentScreenIndex];
}


@end
