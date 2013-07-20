//
//  ViewController.m
//  SuicidePrevention
//
//  Created by Lucas Best on 7/19/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "ViewController.h"

#import "UIImageCreator.h"

@interface ViewController (){
    IBOutlet UIScrollView* scrollView;
    
    IBOutlet UIImageView* imageView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    imageView.image = [UIImageCreator hexagonImageWithSize:imageView.frame.size borderWidth:10.0 andColor:[UIColor redColor]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
