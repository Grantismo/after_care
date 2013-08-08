//
//  Website.m
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "Website.h"
#import "WebsiteCell.h"
#import "WebViewController.h"
#import "CellFactory.h"

@implementation Website

@dynamic url;
@dynamic title;
@dynamic descript;
@dynamic imageUrl;
@synthesize color;


-(void)onDidSelectCell{
    WebViewController* controller = [[WebViewController alloc] init];
    controller.url = [NSURL URLWithString:self.url];
    [self.delegate pushUIViewController:controller];
}



-(void) bindToUITableViewCell:(UITableViewCell *)cell{
    WebsiteCell* websiteCell = (WebsiteCell*) cell;
    NSMutableString *titleString = [self titleWithNewLine: self.title];
    
    websiteCell.titleLabel.text = titleString.uppercaseString;
    [websiteCell.titleLabel sizeToFit];
    websiteCell.descriptionLabel.text = self.descript;
    websiteCell.descriptionLabel.textColor = [UIColor changeBrightness:self.color amount:.6];
    
    websiteCell.sideImageView.image = [UIImage imageNamed:self.imageUrl];
    websiteCell.sideImageView.overlayColor = self.color;
    websiteCell.informationContentView.backgroundColor = self.color;
}


@end
