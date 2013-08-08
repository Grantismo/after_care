//
//  WebsiteCell.m
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "WebsiteCell.h"
#import "StyleManager.h"

@implementation WebsiteCell

-(void) awakeFromNib{
    [[StyleManager sharedStyleManager] setBoldFontForLabel:self.titleLabel];
    
    self.contentView.backgroundColor = [UIColor afterCareOffBlackColor];
}

@end
