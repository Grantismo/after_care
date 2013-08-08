//
//  TextFieldCell.m
//  Emote
//
//  Created by Grant Warman on 8/8/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        _textField.adjustsFontSizeToFitWidth = YES;
        [_textField setEnabled:YES];

        [self.contentView addSubview:_textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
