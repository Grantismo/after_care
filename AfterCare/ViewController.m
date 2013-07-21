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

#define HEX_PADDING 6.0

@interface ViewController (){
    IBOutlet UIScrollView* scrollView;
    
    NSMutableArray* hexagonButtons;
    
    int numColumns;
    int columnIndex;
    
    CADisplayLink* displayLink;
    
    UIPanGestureRecognizer* panGR;
    
    float hexSpeed;
}

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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(scrollHexagons:)];
    [self.view addGestureRecognizer:panGR];
	
    [self addHexagonWithColor:[UIColor redColor] title:nil];
    [self addHexagonWithColor:[UIColor greenColor] title:@"Button 1"];
    [self addHexagonWithColor:[UIColor yellowColor] title:nil];
    [self addHexagonWithColor:[UIColor redColor] title:nil];
    
    [self addHexagonWithColor:[UIColor greenColor] title:nil];
    [self addHexagonWithColor:[UIColor yellowColor] title:@"Button 3"];
    [self addHexagonWithColor:[UIColor redColor] title:@"Button 2"];
    [self addHexagonWithColor:[UIColor greenColor] title:nil];
    
    [self addHexagonWithColor:[UIColor yellowColor] title:nil];
    [self addHexagonWithColor:[UIColor redColor] title:@"Button 5"];
    [self addHexagonWithColor:[UIColor greenColor] title:@"Button 4"];
    [self addHexagonWithColor:[UIColor yellowColor] title:nil];
    
    [self addHexagonWithColor:[UIColor redColor] title:nil];
    [self addHexagonWithColor:[UIColor greenColor] title:nil];
    [self addHexagonWithColor:[UIColor yellowColor] title:nil];
    [self addHexagonWithColor:[UIColor blueColor] title:nil];
    
    [self addHexagonWithColor:[UIColor blueColor] title:nil];
    [self addHexagonWithColor:[UIColor blueColor] title:nil];
    [self addHexagonWithColor:[UIColor blueColor] title:nil];
    [self addHexagonWithColor:[UIColor blueColor] title:nil];
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    hexSpeed = .5;
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(automaticallyScrollHexagons:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark private methods

-(void) addHexagonWithColor:(UIColor *)color title:(NSString *)buttonTitle{
    float hexagonWidth = (self.view.bounds.size.width / (numColumns - 2))
    ;
    
    float hexagonHeight = hexagonWidth * HEXAGON_WIDTH_HEIGHT_RATIO;
    
    Hexagonbutton* hexagon = [[Hexagonbutton alloc] initWithFrame:CGRectMake(0.0, 0.0, hexagonWidth - HEX_PADDING, 0.0)];
    hexagon.color = color;
    
    [hexagon setTitle:buttonTitle forState:UIControlStateNormal];
    
    //This is hardcoded in, can't figure out the math.
    float centeringX = (self.view.bounds.size.width / 16.0);
    
    float xPos = (columnIndex * hexagonWidth * .75) - centeringX;

    int row = [hexagonButtons count] / numColumns;
    int rowNum = ([hexagonButtons count] % numColumns);
    
    float offset = rowNum % 2 ? hexagonHeight / 2.0 : 0.0;
    
    float yPos = (hexagonHeight * row) + offset;
    
    hexagon.center = CGPointMake(xPos, yPos);
    
    [hexagonButtons addObject:hexagon];
    [self.view addSubview:hexagon];
    
    columnIndex = (columnIndex + 1) % numColumns;
}

-(void) automaticallyScrollHexagons:(CADisplayLink *)displayLink{
    hexSpeed += (.5 - hexSpeed) / 15.0;
     
    for (Hexagonbutton* button in hexagonButtons) {
        button.center = CGPointMake(button.center.x, button.center.y - hexSpeed);
        
        [self checkButtonForPlacement:button];
    }
}

-(void) scrollHexagons:(UIPanGestureRecognizer *)panGestureRecognizer{
    static float startY;
    switch (panGR.state) {
        case UIGestureRecognizerStateBegan:{
            [displayLink invalidate];
            displayLink = nil;
            
            for (Hexagonbutton* button in hexagonButtons) {
                button.scrollBeginY = button.center.y;
            }
            
            startY = [panGestureRecognizer locationInView:self.view].y;
            NSLog(@"started");
            break;
        }
        case UIGestureRecognizerStateChanged:{
          
            hexSpeed = -([panGestureRecognizer locationInView:self.view].y - startY);
            NSLog(@"%f", hexSpeed);

            for (Hexagonbutton* button in hexagonButtons) {
                button.center = CGPointMake(button.center.x, button.scrollBeginY - hexSpeed);
                //[self checkButtonForPlacement:button];
            }

            break;
        }
        case UIGestureRecognizerStateEnded:{
            hexSpeed = -([panGestureRecognizer velocityInView:self.view].y / 60.0);
            
            if (!displayLink){
                displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(automaticallyScrollHexagons:)];
                [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            }
           
            NSLog(@"ended");
            break;
        }
        default:
            break;
    }
}

-(void) checkButtonForPlacement:(Hexagonbutton *)button{    
    if (button.frame.origin.y + button.frame.size.height < 0.0 && hexSpeed > 0) {
        float hexagonWidth = (self.view.bounds.size.width / (numColumns - 2));
        float hexagonHeight = hexagonWidth * HEXAGON_WIDTH_HEIGHT_RATIO;
        
        int aboveRowIndex = [hexagonButtons indexOfObject:button] - numColumns;
        
        int index = aboveRowIndex % [hexagonButtons count];
        if (aboveRowIndex < 0) index += numColumns;
        
        Hexagonbutton* aboveButton = [hexagonButtons objectAtIndex:index];
        
        button.center = CGPointMake(button.center.x, aboveButton.center.y + hexagonHeight);
    }
    if (button.frame.origin.y > self.view.bounds.size.height && hexSpeed < 0) {
        float hexagonWidth = (self.view.bounds.size.width / (numColumns - 2));
        float hexagonHeight = hexagonWidth * HEXAGON_WIDTH_HEIGHT_RATIO;
        
        int aboveRowIndex = [hexagonButtons indexOfObject:button] + numColumns;
        
        int index = aboveRowIndex % [hexagonButtons count];
        if (aboveRowIndex < 0) index += numColumns;
        
        Hexagonbutton* belowButton = [hexagonButtons objectAtIndex:index];
        
        button.center = CGPointMake(button.center.x, belowButton.center.y - hexagonHeight);
    }
}

@end
