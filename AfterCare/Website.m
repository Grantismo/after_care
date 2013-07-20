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


-(void)onDidSelectCell{
    WebViewController* controller = [[WebViewController alloc] init];
    controller.url = [NSURL URLWithString:self.url];
    [self.delegate pushUIViewController:controller];
}

-(void) bindToUITableViewCell:(UITableViewCell *)cell{
    WebsiteCell* websiteCell = (WebsiteCell*) cell;
    websiteCell.titleLabel.text = self.title.uppercaseString;
    websiteCell.descriptionLabel.text = self.descript;
    websiteCell.imageView.image =   [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageUrl]]];
}


@end
