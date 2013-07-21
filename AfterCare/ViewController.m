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

#define HEX_PADDING 6.0

@interface ViewController (){
    IBOutlet UIScrollView* scrollView;
    
    NSMutableArray* hexagonButtons;
    
    int numColumns;
    int columnIndex;
}

-(void) addHexagonWithColor:(UIColor*) color title:(NSString*) buttonTitle;

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
	
    [self addHexagonWithColor:[UIColor redColor] title:@"Button 1"];
    [self addHexagonWithColor:[UIColor greenColor] title:@"Button 2"];
    [self addHexagonWithColor:[UIColor yellowColor] title:@"Button 3"];
    [self addHexagonWithColor:[UIColor redColor] title:@"Button 4"];
    [self addHexagonWithColor:[UIColor greenColor] title:@"Button 5"];
    [self addHexagonWithColor:[UIColor yellowColor] title:@"Button 6"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark private methods

-(void) addHexagonWithColor:(UIColor *)color title:(NSString *)buttonTitle{
    float hexagonWidth = (self.view.bounds.size.width / (numColumns - 2));
    float hexagonHeight = hexagonWidth * HEXAGON_WIDTH_HEIGHT_RATIO;
    
    Hexagonbutton* hexagon = [[Hexagonbutton alloc] initWithFrame:CGRectMake(0.0, 0.0, hexagonWidth - HEX_PADDING, 0.0)];
    hexagon.color = color;
    
    [hexagon setTitle:buttonTitle forState:UIControlStateNormal];
    
    float centeringX = (self.view.bounds.size.width - ((hexagonWidth * numColumns) * 1.5)) / 2.0;
    
    float xPos = (columnIndex * hexagonWidth * .75) - centeringX;

    int row = [hexagonButtons count] / numColumns;
    int rowNum = ([hexagonButtons count] % numColumns);
    
    float offset = rowNum % 2 ? hexagonHeight / 2.0 : 0.0;
    
    float yPos = (hexagonHeight * row) + offset;
    
    [hexagon setOrigin:CGPointMake(xPos, yPos)];
    
    [hexagonButtons addObject:hexagon];
    [self.view addSubview:hexagon];
    
    columnIndex = (columnIndex + 1) % numColumns;
}

@end
