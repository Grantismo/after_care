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
@synthesize color;



-(void)onDidSelectCell{
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.number];
    NSLog(@"Calling number... %@", phoneNumber);

    BOOL opened = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];

}

-(void) bindToUITableViewCell:(UITableViewCell *)cell{
    PhoneNumberCell* phoneCell = (PhoneNumberCell*) cell;
    phoneCell.titleLabel.text = [@"Call " stringByAppendingString:self.name];
    phoneCell.descriptionLabel.text = self.descript;
    phoneCell.imageView.image = [UIImage imageNamed: @"resource_image1.png"]; // [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageUrl]]];
    phoneCell.contentView.backgroundColor = self.color;
}

@end
