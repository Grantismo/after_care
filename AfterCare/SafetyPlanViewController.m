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

typedef enum SafetyPlanContentTag{
    SafetyPlanContentTag_WarningSigns,
    SafetyPlanContentTag_Tag2,
    SafetyPlanContentTag_Places,
    SafetyPlanContentTag_Tag4,
    SafetyPlanContentTag_Agencies,
    SafetyPlanContentTag_Tag6
}SafetyPlanContentTag;

@interface SafetyPlanViewController (){
    IBOutlet UIButton* backButton;
    IBOutlet UIView* littleYellowArrowImageContainer;
    IBOutlet UIImageView* littleYellowArrowImage;
    
    IBOutlet UILabel* titleLabel;
    IBOutlet UILabel* descriptionLabel;
    
    IBOutlet UIView* contentView;
    
    IBOutlet SafetyPlanWarningSignsScreen* warningSignScreen;
    
    id<SafetyPlanScreen> currentScreen;
    
    SafetyPlanContentTag currentTag;
}

-(IBAction) dismiss:(id) sender;
-(IBAction)setContent:(UIButton*) sender;


-(void) animateNewScreen:(id<SafetyPlanScreen>) screen withNewTitleText:(NSString*) titleText withNewDescriptionText:(NSString*) descriptionText;

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
    
    currentScreen = warningSignScreen;
    [currentScreen addToView:contentView];
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
    if (currentTag != sender.tag){
        switch (sender.tag) {
            case SafetyPlanContentTag_WarningSigns:
                [self animateNewScreen:warningSignScreen withNewTitleText:@"Part 1: Warning Signs" withNewDescriptionText:@"These are thoughts, images, moods, situations or behavior that indicate a crisis that may be developing."];
                break;
            case SafetyPlanContentTag_Tag2:
                [self animateNewScreen:warningSignScreen withNewTitleText:@"Part 2: Things" withNewDescriptionText:@"Things happen."];
                break;
            case SafetyPlanContentTag_Places:
                [self animateNewScreen:warningSignScreen withNewTitleText:@"Part 3: Places and Social Settings" withNewDescriptionText:@"These are active, engaging locations like parks, museums, or even a friend's house, that provide distraction."];
                break;
            case SafetyPlanContentTag_Tag4:
                [self animateNewScreen:warningSignScreen withNewTitleText:@"Part 4: More Shit" withNewDescriptionText:@"Shit happens too."];
                break;
            case SafetyPlanContentTag_Agencies:
                [self animateNewScreen:warningSignScreen withNewTitleText:@"Part 5: Professionals and Agencies" withNewDescriptionText:@"It's helpful to have contact information for professionals, clinics, urgent care services, and lifelines. Enter yours here."];
                break;
            case SafetyPlanContentTag_Tag6:
                [self animateNewScreen:warningSignScreen withNewTitleText:@"Part 6: Even More" withNewDescriptionText:@"Even More."];
                break;
                
            default:
                break;
        }
    }
    
    currentTag = sender.tag;
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

-(void) animateNewScreen:(id<SafetyPlanScreen>)screen withNewTitleText:(NSString *)titleText withNewDescriptionText:(NSString *)descriptionText{
    [UIView animateWithDuration:.2 animations:^{
        titleLabel.alpha = 0.0;
        descriptionLabel.alpha = 0.0;
        
        [currentScreen animateOut];
    } completion:^(BOOL finished) {
        titleLabel.text = titleText;
        descriptionLabel.text = descriptionText;
        
        currentScreen = screen;
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


@end
