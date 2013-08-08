//
//  WebsiteCell.h
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "ColorTintImageView.h"

@interface WebsiteCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView* informationContentView;
@property (nonatomic, strong) IBOutlet UILabel* titleLabel;
@property (nonatomic, strong) IBOutlet UILabel* descriptionLabel;
@property (nonatomic, strong) IBOutlet ColorTintImageView* sideImageView;

@end
