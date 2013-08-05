//
//  ViewController.m
//  SuicidePrevention
//
//  Created by Lucas Best on 7/19/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "HexagonMainViewController.h"

#import "UIView+FrameManipulators.h"
#import "Hexagonbutton.h"

#import <QuartzCore/QuartzCore.h>

#import "WebViewController.h"

#import "SafetyPlanViewController.h"
#import "StyleManager.h"

#define HEX_PADDING 6.0

@interface HexagonMainViewController ()<SafetyPlanDelegate>{
    IBOutlet UIView* contentView;
    
    NSMutableArray* hexagonButtons;
    
    int numColumns;
    int columnIndex;
    
    CADisplayLink* displayLink;
    
    UIPanGestureRecognizer* panGR;
    
    float hexSpeed;
    float hexagonWidth;
    float hexagonHeight;
    
    BOOL levelOutScrollSpeed;
    
    UINavigationController* safetyNavigationController;
    SafetyPlanViewController* safetyPlanViewController;
}

-(IBAction) hexagonPress:(Hexagonbutton*) button;

-(void) addHexagonWithColor:(UIColor*) color title:(NSString*) buttonTitle;

-(void) automaticallyScrollHexagons:(CADisplayLink*) displayLink;
-(void) scrollHexagons:(UIPanGestureRecognizer*) panGestureRecognizer;
-(void) checkButtonForPlacement:(Hexagonbutton*) button;

-(void)animateSafetyPlanIn:(UITapGestureRecognizer*) navTapGR;

@end

@implementation HexagonMainViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        hexagonButtons = [[NSMutableArray alloc] init];
        numColumns = 4;
        
        levelOutScrollSpeed = TRUE;
        
        self.title= @"How are you feeling today?";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[StyleManager sharedStyleManager] appendTitleTextAttributes:@{UITextAttributeTextColor : [UIColor afterCareOffWhiteColor]} toNavigationBar:self.navigationController.navigationBar];
    
    hexagonWidth = (self.view.bounds.size.width * (4.0 / 7.0));
    hexagonHeight = hexagonWidth * HEXAGON_WIDTH_HEIGHT_RATIO;
    
    self.view.backgroundColor = [UIColor afterCareOffBlackColor];
    
    panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(scrollHexagons:)];
    [self.view addGestureRecognizer:panGR];
	
    [self addHexagonWithColor:[UIColor afterCareTransparentColor1] title:nil];
    [self addHexagonWithColor:[UIColor positiveColor] title:@"POSITIVE"];
    [self addHexagonWithColor:[UIColor angryColor] title:@"ANGRY"];
    [self addHexagonWithColor:[UIColor afterCareTransparentColor2] title:nil];
    
    [self addHexagonWithColor:[UIColor afterCareTransparentColor3] title:nil];
    [self addHexagonWithColor:[UIColor lonelyColor] title:@"LONELY"];
    [self addHexagonWithColor:[UIColor depressedColor] title:@"DEPRESSED"];
    [self addHexagonWithColor:[UIColor afterCareTransparentColor4] title:nil];
    
    [self addHexagonWithColor:[UIColor afterCareTransparentColor5] title:nil];
    [self addHexagonWithColor:[UIColor hurtColor] title:@"HURT"];
    [self addHexagonWithColor:[UIColor gratefulColor] title:@"GRATEFUL"];
    [self addHexagonWithColor:[UIColor afterCareTransparentColor6] title:nil];
    
    [self addHexagonWithColor:[UIColor afterCareTransparentColor7] title:nil];
    [self addHexagonWithColor:[UIColor worthlessColor] title:@"WORTHLESS"];
    [self addHexagonWithColor:[UIColor disinterestedColor] title:@"DISINTERESTED"];
    [self addHexagonWithColor:[UIColor afterCareTransparentColor1] title:nil];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImageCreator onePixelImageForColor:[UIColor afterCareOffBlackColor]] forBarMetrics:UIBarMetricsDefault];
    
    safetyPlanViewController = [[SafetyPlanViewController alloc] initWithNibName:NSStringFromClass([SafetyPlanViewController class]) bundle:nil];
    safetyPlanViewController.delegate = self;
    
    safetyNavigationController = [[UINavigationController alloc] initWithRootViewController:safetyPlanViewController];
    
    safetyNavigationController.view.frame = CGRectMake(safetyNavigationController.view.frame.origin.x,
                                          self.navigationController.view.bounds.size.height - safetyNavigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height,
                                          safetyNavigationController.view.frame.size.width,
                                          safetyNavigationController.view.frame.size.height);
    
    UITapGestureRecognizer* navTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animateSafetyPlanIn:)];
    navTap.numberOfTapsRequired = 1;
    navTap.numberOfTouchesRequired = 1;
    
    [safetyNavigationController.view addGestureRecognizer:navTap];
    
    [self.navigationController.view addSubview:safetyNavigationController.view];
    
    contentView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - safetyNavigationController.navigationBar.frame.size.height - .5);
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    hexSpeed = -1;
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(automaticallyScrollHexagons:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark safetyPlanDelegate methods

-(void) dismissSafetyPlayController:(SafetyPlanViewController *)controller{
    self.view.hidden = FALSE;
    
    [safetyPlanViewController animateArrow:FALSE withDuration:.2];
    
    [UIView animateWithDuration:.2 animations:^{
        safetyNavigationController.view.frame = CGRectMake(safetyNavigationController.view.frame.origin.x,
                                                           self.navigationController.view.bounds.size.height - safetyNavigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height,
                                                           safetyNavigationController.view.frame.size.width,
                                                           safetyNavigationController.view.frame.size.height);
    } completion:^(BOOL finished) {
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(automaticallyScrollHexagons:)];
        [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }];
}

#pragma mark Actions

-(IBAction) hexagonPress:(Hexagonbutton *)button{
    [displayLink invalidate];
    displayLink = nil;
    
    [contentView addSubview:button];
}

#pragma mark private methods

-(void) addHexagonWithColor:(UIColor *)color title:(NSString *)buttonTitle{
    
    Hexagonbutton* hexagon = [[Hexagonbutton alloc] initWithFrame:CGRectMake(0.0, 0.0, hexagonWidth - HEX_PADDING, 0.0)];
    hexagon.color = color;
    
    [hexagon setTitle:buttonTitle forState:UIControlStateNormal];
    
    [hexagon addTarget:self action:@selector(hexagonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    //This is hardcoded in, can't figure out the math.
    float centeringX = (self.view.bounds.size.width / 2.0) - (hexagonWidth * 9.0 / 8.0);
    
    float xPos = (columnIndex * hexagonWidth * .75) + centeringX;

    int row = [hexagonButtons count] / numColumns;
    int rowNum = ([hexagonButtons count] % numColumns);
    
    float offset = rowNum % 2 ? hexagonHeight / 2.0 : 0.0;
    
    float yPos = (hexagonHeight * row) + offset;
    
    hexagon.center = CGPointMake(xPos, yPos);
    
    [hexagonButtons addObject:hexagon];
    [contentView addSubview:hexagon];
    
    columnIndex = (columnIndex + 1) % numColumns;
}

-(void) automaticallyScrollHexagons:(CADisplayLink *)displayLink{
    if (levelOutScrollSpeed) hexSpeed += (-.5 - hexSpeed) / 15.0;
     
    for (Hexagonbutton* button in hexagonButtons) {
        button.center = CGPointMake(button.center.x, button.center.y + hexSpeed);
    }
    
    for (Hexagonbutton* button in hexagonButtons) {
        [self checkButtonForPlacement:button];
    }
}

-(void) scrollHexagons:(UIPanGestureRecognizer *)panGestureRecognizer{
    switch (panGR.state) {
        case UIGestureRecognizerStateBegan:{
            levelOutScrollSpeed = FALSE;
            break;
        }
        case UIGestureRecognizerStateChanged:{
            static float lastYLocation;
            float currentYLocation = [panGestureRecognizer locationInView:self.view].y;
            hexSpeed = currentYLocation - lastYLocation;
            lastYLocation = currentYLocation;

            break;
        }
        case UIGestureRecognizerStateEnded:{
            hexSpeed = [panGestureRecognizer velocityInView:self.view].y / 60.0;
            
            levelOutScrollSpeed = TRUE;
            break;
        }
        default:
            break;
    }
}

-(void) checkButtonForPlacement:(Hexagonbutton *)button{
    if (button.frame.origin.y + button.frame.size.height < 0.0 && hexSpeed < 0) {
        [self updateButtonCenter:button above:YES];
    }
    
    if (button.frame.origin.y > contentView.bounds.size.height && hexSpeed > 0) {
        [self updateButtonCenter:button above:NO];
    }
}

-(void) updateButtonCenter: (Hexagonbutton*) button above: (BOOL) above{
    
    int referenceIndex = [hexagonButtons indexOfObject:button];
    
    int index = 0;
    if (above) {
        index =  (referenceIndex + hexagonButtons.count - numColumns) % hexagonButtons.count;
    }
    else{
        index =  (referenceIndex - hexagonButtons.count + numColumns) % hexagonButtons.count;
    }
    
    Hexagonbutton* referenceButton = [hexagonButtons objectAtIndex:index];
    int dir = above ? 1 : -1;
    button.center = CGPointMake(button.center.x, referenceButton.center.y + (dir * hexagonHeight));
}

-(void) animateSafetyPlanIn:(UITapGestureRecognizer *)navTapGR{
    [displayLink invalidate];
    displayLink = nil;
    
    [safetyPlanViewController animateArrow:TRUE withDuration:.5];
    
    [UIView animateWithDuration:.5 delay:.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        safetyNavigationController.view.frame = self.navigationController.view.bounds;
    } completion:^(BOOL finished) {
        [safetyPlanViewController addBackButton];
        self.view.hidden = TRUE;
    }];
}

@end
