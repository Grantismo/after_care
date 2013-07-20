//
//  WebsiteCell.h
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebsiteCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* titleLabel;
@property (nonatomic, strong) IBOutlet UILabel* descriptionLabel;
@property (nonatomic, strong) IBOutlet UIImageView* imageView;

@end
