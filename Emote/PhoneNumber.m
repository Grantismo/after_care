//
//  PhoneNumber.m
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "PhoneNumber.h"
#import "CellDataProvider.h"
#import "PhoneNumberCell.h"

@implementation PhoneNumber
@dynamic name;
@dynamic number;
@dynamic descript;
@dynamic imageUrl;
@synthesize color;



-(void)onDidSelectCell{
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.number];
    NSLog(@"Calling number... %@", phoneNumber);

}

-(void) bindToUITableViewCell:(UITableViewCell *)cell{
    PhoneNumberCell* phoneCell = (PhoneNumberCell*) cell;
    NSMutableString *titleString = [self titleWithNewLine: self.name];

    phoneCell.titleLabel.text = titleString.uppercaseString;
    [phoneCell.titleLabel sizeToFit];

    phoneCell.descriptionLabel.text = self.descript;
    phoneCell.descriptionLabel.textColor = [UIColor changeBrightness:self.color amount:0.65];
    
    phoneCell.sideImageView.image = [UIImage imageNamed:self.imageUrl];
    phoneCell.sideImageView.overlayColor = self.color;
    phoneCell.informationContentView.backgroundColor = self.color;
}

@end
