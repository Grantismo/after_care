//
//  AddYourOwnResourcesTableViewCell.m
//  Emote
//
//  Created by Lucas Best on 8/8/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "AddYourOwnResourcesCell.h"
#import "StyleManager.h"

#import "ColorTintImageView.h"

@interface AddYourOwnResourcesCell (){
    IBOutlet UILabel* titleLabel;
    
    IBOutlet ColorTintImageView* sideImageView;
}

@end

@implementation AddYourOwnResourcesCell

-(void) awakeFromNib{
    [[StyleManager sharedStyleManager] setBoldFontForLabel:titleLabel];
    [[StyleManager sharedStyleManager] setItalicFontForLabel:self.descriptionLabel];
            
    sideImageView.overlayColor = [UIColor greenColor];
}

@end
