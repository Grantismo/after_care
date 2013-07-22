//
//  ViewController.m
//  SuicidePrevention
//
//  Created by Lucas Best on 7/19/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "ViewController.h"

#import "UIView+FrameManipulators.h"
#import "Hexagonbutton.h"

#import <QuartzCore/QuartzCore.h>

#import "WebViewController.h"

#define HEX_PADDING 6.0

@interface ViewController (){
    IBOutlet UINavigationBar* navBar;
    IBOutlet UIView* contentView;
    IBOutlet UIButton* safetyPlanButton;
    
    NSMutableArray* hexagonButtons;
    
    int numColumns;
    int columnIndex;
    
    CADisplayLink* displayLink;
    
    UIPanGestureRecognizer* panGR;
    
    float hexSpeed;
    float hexagonWidth;
    float hexagonHeight;
    
    BOOL levelOutScrollSpeed;
}

-(IBAction) hexagonPress:(Hexagonbutton*) button;

-(void) addHexagonWithColor:(UIColor*) color title:(NSString*) buttonTitle;

-(void) automaticallyScrollHexagons:(CADisplayLink*) displayLink;
-(void) scrollHexagons:(UIPanGestureRecognizer*) panGestureRecognizer;
-(void) checkButtonForPlacement:(Hexagonbutton*) button;

@end

@implementation ViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        hexagonButtons = [[NSMutableArray alloc] init];
        numColumns = 4;
        
        levelOutScrollSpeed = TRUE;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    hexagonWidth = (self.view.bounds.size.width * (4.0 / 7.0));
    hexagonHeight = hexagonWidth * HEXAGON_WIDTH_HEIGHT_RATIO;
    
    self.view.backgroundColor = [UIColor afterCareOffBlackColor];
    
    [safetyPlanButton setBackgroundImage:[UIImageCreator onePixelImageForColor:[UIColor afterCareOffWhiteColor]] forState:UIControlStateNormal];
    
    panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(scrollHexagons:)];
    [self.view addGestureRecognizer:panGR];
	
    [self addHexagonWithColor:[UIColor afterCareColor1] title:nil];
    [self addHexagonWithColor:[UIColor afterCareColor2] title:@"POSITIVE"];
    [self addHexagonWithColor:[UIColor afterCareColor7] title:@"IRRITATED"];
    [self addHexagonWithColor:[UIColor afterCareColor4] title:nil];
    
    [self addHexagonWithColor:[UIColor afterCareColor3] title:nil];
    [self addHexagonWithColor:[UIColor afterCareColor5] title:@"GENEROUS"];
    [self addHexagonWithColor:[UIColor afterCareColor1] title:@"DEPRESSED"];
    [self addHexagonWithColor:[UIColor afterCareColor7] title:nil];
    
    [self addHexagonWithColor:[UIColor afterCareColor2] title:nil];
    [self addHexagonWithColor:[UIColor afterCareColor4] title:@"SPITEFUL"];
    [self addHexagonWithColor:[UIColor afterCareColor6] title:@"AN ASSHOLE"];
    [self addHexagonWithColor:[UIColor afterCareColor3] title:nil];
    
    [self addHexagonWithColor:[UIColor afterCareColor7] title:nil];
    [self addHexagonWithColor:[UIColor afterCareColor1] title:@"HURT"];
    [self addHexagonWithColor:[UIColor afterCareColor2] title:@"ANGRY"];
    [self addHexagonWithColor:[UIColor afterCareColor6] title:nil];
    
    [self addHexagonWithColor:[UIColor afterCareColor3] title:nil];
    [self addHexagonWithColor:[UIColor afterCareColor5] title:@"APATHETIC"];
    [self addHexagonWithColor:[UIColor afterCareColor4] title:@"LONELY"];
    [self addHexagonWithColor:[UIColor afterCareColor2] title:nil];
    
    [navBar setBackgroundImage:[UIImageCreator onePixelImageForColor:[UIColor afterCareOffBlackColor]] forBarMetrics:UIBarMetricsDefault];
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

#pragma mark Actions

-(IBAction) hexagonPress:(Hexagonbutton *)button{
    [displayLink invalidate];
    displayLink = nil;
    
    [contentView addSubview:button];
    
    [UIView animateWithDuration:2.0 delay:.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (Hexagonbutton* hexButton in hexagonButtons) {
            if (hexButton != button){
                hexButton.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(.7, .7), CGAffineTransformMakeRotation(1.0));
            }
        }
        
        button.transform = CGAffineTransformMakeScale(10.0, 10.0);
        button.titleLabel.alpha = 0.0;
        
        contentView.frame = self.view.bounds;
        
        [navBar setOrigin:CGPointMake(navBar.frame.origin.x, -navBar.frame.size.height)];
        [safetyPlanButton setOrigin:CGPointMake(safetyPlanButton.frame.origin.x, self.view.bounds.size.height)];
    } completion:^(BOOL finished) {
    
    }];
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
    int dir = above ? 1 : -1;
    int referenceIndex = [hexagonButtons indexOfObject:button] - (dir * numColumns);
    
    int index = referenceIndex % [hexagonButtons count];
    if (referenceIndex < 0) index += numColumns;
    
    Hexagonbutton* referenceButton = [hexagonButtons objectAtIndex:index];
    button.center = CGPointMake(button.center.x, referenceButton.center.y + (dir * hexagonHeight));
}

@end
