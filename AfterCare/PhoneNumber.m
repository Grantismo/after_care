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

    BOOL opened = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];

}

-(void) bindToUITableViewCell:(UITableViewCell *)cell{
    PhoneNumberCell* phoneCell = (PhoneNumberCell*) cell;
    phoneCell.titleLabel.text = self.name.uppercaseString;
    phoneCell.descriptionLabel.text = self.descript;
    phoneCell.descriptionLabel.textColor = [UIColor changeBrightness:self.color amount:.6];
    
    phoneCell.sideImageView.image = [UIImage imageNamed:self.imageUrl];
    phoneCell.sideImageView.overlayColor = self.color;
    phoneCell.informationContentView.backgroundColor = self.color;
}

@end
