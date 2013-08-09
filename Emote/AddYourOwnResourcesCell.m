//
//  AddYourOwnResourcesTableViewCell.m
//  Emote
//
//  Created by Lucas Best on 8/8/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "AddYourOwnResourcesCell.h"
#import "StyleManager.h"

@interface AddYourOwnResourcesCell (){
    IBOutlet UILabel* titleLabel;
}

@end

@implementation AddYourOwnResourcesCell

-(void) awakeFromNib{
    [[StyleManager sharedStyleManager] setBoldFontForLabel:titleLabel];
    //[[StyleManager sharedStyleManager] setItalicFontForLabel:self.descriptionLabel];
            
    self.sideImageView.image = [UIImage imageNamed:@"add_your_own_resource"];
}

@end
