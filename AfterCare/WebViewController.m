//
//  WebViewController.m
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "WebViewController.h"
#import "UIImageCreator.h"
#import "StyleManager.h"

@interface WebViewController ()<UIWebViewDelegate>{
    IBOutlet UIButton* backButton;
    
    IBOutlet UIActivityIndicatorView* activityIndicator;
}

-(IBAction)goBack:(id)sender;

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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [[StyleManager sharedStyleManager] setBoldFontForLabel:backButton.titleLabel];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
     [self.navigationController.navigationBar setBackgroundImage:[UIImageCreator onePixelImageForColor:self.navbarColor] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.tintColor = self.navbarColor;
    
    
    [activityIndicator setColor:self.navbarColor];
}

#pragma mark UIWebView delegate methods

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [UIView animateWithDuration:.5 animations:^{
        activityIndicator.alpha = 0.0;
    } completion:^(BOOL finished) {
        [activityIndicator removeFromSuperview];
    }];
}

-(void) webViewDidStartLoad:(UIWebView *)webView{
    
}

#pragma mark Actions

-(IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
