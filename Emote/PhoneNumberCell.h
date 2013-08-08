//
//  PhoneNumberCell.h
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorTintImageView.h"

@interface PhoneNumberCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView* informationContentView;
@property (nonatomic, strong) IBOutlet UILabel* titleLabel;
@property (nonatomic, strong) IBOutlet UILabel* descriptionLabel;
@property (nonatomic, strong) IBOutlet ColorTintImageView* sideImageView;


@end
