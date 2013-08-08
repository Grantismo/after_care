//
//  WebViewController.h
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView* webView;
@property (nonatomic, strong) NSURL* url;

@property (nonatomic, strong) UIColor* navbarColor;
@end
