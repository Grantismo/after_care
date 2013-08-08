//
//  PhoneNumberCell.m
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "PhoneNumberCell.h"
#import "StyleManager.h"

@implementation PhoneNumberCell

-(void) awakeFromNib{
    [[StyleManager sharedStyleManager] setBoldFontForLabel:self.titleLabel];
    //[[StyleManager sharedStyleManager] setItalicFontForLabel:self.descriptionLabel];
    
    self.contentView.backgroundColor = [UIColor afterCareOffBlackColor];
}

@end
