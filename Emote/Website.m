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
    WebViewController* controller = [[WebViewController alloc] initWithNibName:NSStringFromClass([WebViewController class]) bundle:nil];
    controller.url = [NSURL URLWithString:self.url];
    controller.navbarColor = self.color;
    
    controller.title = self.title.capitalizedString;
    
    [self.delegate pushUIViewController:controller];
}



-(void) bindToUITableViewCell:(UITableViewCell *)cell{
    WebsiteCell* websiteCell = (WebsiteCell*) cell;
    NSMutableString *titleString = [self titleWithNewLine: self.title];
    
    websiteCell.titleLabel.text = titleString.uppercaseString;
    [websiteCell.titleLabel sizeToFit];
    websiteCell.descriptionLabel.text = self.descript;
    websiteCell.descriptionLabel.textColor = [UIColor changeBrightness:self.color amount:.65];
    
    CGSize size = [websiteCell.titleLabel.text sizeWithFont:websiteCell.titleLabel.font constrainedToSize:websiteCell.titleLabel.frame.size];
    
    float descriptionY = websiteCell.titleLabel.frame.origin.y + size.height + 4.0;
    
    websiteCell.descriptionLabel.frame = CGRectMake(websiteCell.descriptionLabel.frame.origin.x,
                                                    websiteCell.titleLabel.frame.origin.y + size.height,
                                                    websiteCell.descriptionLabel.frame.size.width,
                                                    websiteCell.frame.size.height - descriptionY - 8.0);
    
    websiteCell.sideImageView.image = [UIImage imageNamed:self.imageUrl];
    websiteCell.sideImageView.overlayColor = self.color;
    websiteCell.informationContentView.backgroundColor = self.color;
}


@end
