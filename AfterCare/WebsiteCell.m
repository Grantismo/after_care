//
//  WebsiteCell.m
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "WebsiteCell.h"

@implementation WebsiteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void) awakeFromNib{
    self.titleLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:self.textLabel.font.pointSize];
    self.descriptionLabel.font = [UIFont fontWithName:@"OpenSans" size:self.textLabel.font.pointSize];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
