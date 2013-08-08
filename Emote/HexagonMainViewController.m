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
#import "ResourcesViewController.h"

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
    NSArray* emotions;
    NSArray* alternateColors;
}

-(IBAction) hexagonPress:(Hexagonbutton*) button;

-(void) addHexagonWithColor:(UIColor *)color title:(NSString *)buttonTitle index: (int) emotionIndex;

-(void) automaticallyScrollHexagons:(CADisplayLink*) displayLink;
-(void) scrollHexagons:(UIPanGestureRecognizer*) panGestureRecognizer;
-(void) checkButtonForPlacement:(Hexagonbutton*) button;

-(void)animateSafetyPlanIn:(UITapGestureRecognizer*) navTapGR;
-(Emotion *) emotionAtButton: (Hexagonbutton*) button;

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
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setShadowImage:)])
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    emotions = [self.managedObjectContext executeFetchRequest:[Emotion fetchRequest: self.managedObjectContext] error:nil];
    alternateColors = [NSArray arrayWithObjects:[UIColor afterCareTransparentColor1], [UIColor afterCareTransparentColor2], [UIColor afterCareTransparentColor3], [UIColor afterCareTransparentColor4], [UIColor afterCareTransparentColor5], [UIColor afterCareTransparentColor6], [UIColor afterCareTransparentColor7], nil];
    
    
    [[StyleManager sharedStyleManager] appendTitleTextAttributes:@{UITextAttributeTextColor : [UIColor afterCareOffWhiteColor]} toNavigationBar:self.navigationController.navigationBar];
    
    hexagonWidth = (self.view.bounds.size.width * (4.0 / 7.0));
    hexagonHeight = hexagonWidth * HEXAGON_WIDTH_HEIGHT_RATIO;
    
    self.view.backgroundColor = [UIColor afterCareOffBlackColor];
    
    panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(scrollHexagons:)];
    
    [self.view addGestureRecognizer:panGR];
	
    int altColorIndex = 0;
    int emotionIndex = 0;
    
    for(int i = 0; i < 16; i++){
        NSString* title;
        UIColor* color;
        int index;

        
        int col = i % 4;
        if(col == 0 || col == 3){
            title = @"";
            color = [alternateColors objectAtIndex:(altColorIndex % alternateColors.count)];
            altColorIndex++;
            index = -1;
        }else{
            Emotion *emotion = [emotions objectAtIndex:emotionIndex];
            title = emotion.name;
            color = emotion.color;
            index = emotionIndex;
            emotionIndex++;
        }
        
        [self addHexagonWithColor:color title:title index:index];
    }
    
    safetyPlanViewController = [[SafetyPlanViewController alloc] initWithNibName:NSStringFromClass([SafetyPlanViewController class]) bundle:nil];
    safetyPlanViewController.delegate = self;
    safetyPlanViewController.managedObjectContext = self.managedObjectContext;
    
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
    
    contentView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - safetyNavigationController.navigationBar.frame.size.height);
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    hexSpeed = -1;
    
     [self.navigationController.navigationBar setBackgroundImage:[UIImageCreator onePixelImageForColor:[UIColor afterCareOffBlackColor]] forBarMetrics:UIBarMetricsDefault];
    
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

-(Emotion *) emotionAtButton: (Hexagonbutton*) button{
    int index = button.tag;
    if(index == -1){
        return nil;
    }
    return [emotions objectAtIndex:index];
}

#pragma mark Actions

-(IBAction) hexagonPress:(Hexagonbutton *)button{
    
    
    Emotion* emotion = [self emotionAtButton:button];
    if(emotion != nil){
        [displayLink invalidate];
        displayLink = nil;
        ResourcesViewController* resourceViewController = [[ResourcesViewController alloc] initWithEmotion: emotion];
        resourceViewController.managedObjectContext = self.managedObjectContext;
        
        [self.navigationController pushViewController:resourceViewController animated:YES];
    }
    
    
}

#pragma mark private methods

-(void) addHexagonWithColor:(UIColor *)color title:(NSString *)buttonTitle index: (int) emotionIndex{
    Hexagonbutton* hexagon = [[Hexagonbutton alloc] initWithFrame:CGRectMake(0.0, 0.0, hexagonWidth - HEX_PADDING, 0.0)];
    hexagon.color = color;
    hexagon.text = buttonTitle;
    hexagon.tag = emotionIndex;
    
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
