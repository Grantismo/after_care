//
//  WebViewController.m
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    
    //Move out of the way of safety plan nav controller whose navigation bar is the same height as this one.
    self.webView.frame = CGRectMake(0.0,
                                      self.webView.frame.origin.y,
                                      self.webView.frame.size.width,
                                      self.webView.frame.size.height - self.navigationController.navigationBar.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
