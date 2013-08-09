//
//  AddYourOwnResourcesTableViewCell.h
//  Emote
//
//  Created by Lucas Best on 8/8/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "ColorTintImageView.h"

@interface AddYourOwnResourcesCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView* informationContentView;
@property (nonatomic, strong) IBOutlet UILabel* descriptionLabel;

@property (nonatomic, strong) IBOutlet ColorTintImageView* sideImageView;

@end
