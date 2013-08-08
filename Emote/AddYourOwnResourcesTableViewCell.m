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
    IBOutlet UILabel* titleLabel;
    
    IBOutlet ColorTintImageView* sideImageView;
}

@end

@implementation AddYourOwnResourcesTableViewCell

-(void) awakeFromNib{
    [[StyleManager sharedStyleManager] setBoldFontForLabel:titleLabel];
    [[StyleManager sharedStyleManager] setItalicFontForLabel:self.descriptionLabel];
            
    sideImageView.overlayColor = [UIColor greenColor];
}

@end
