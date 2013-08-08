//
//  AddYourOwnResourcesTableViewCell.m
//  Emote
//
//  Created by Lucas Best on 8/8/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "AddYourOwnResourcesTableViewCell.h"
#import "StyleManager.h"

#import "ColorTintImageView.h"

@interface AddYourOwnResourcesTableViewCell (){
    IBOutlet UIView* informationContentView;
    IBOutlet UILabel* titleLabel;
    IBOutlet UILabel* descriptionLabel;
    
    IBOutlet ColorTintImageView* sideImageView;
}

@end

@implementation AddYourOwnResourcesTableViewCell

-(void) awakeFromNib{
    [[StyleManager sharedStyleManager] setBoldFontForLabel:titleLabel];
    [[StyleManager sharedStyleManager] setItalicFontForLabel:descriptionLabel];
    
    informationContentView.backgroundColor = [UIColor greenColor];
    
    sideImageView.image = [UIImage imageNamed:@"default_image_1"];
    
    sideImageView.overlayColor = [UIColor greenColor];
}

@end
