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


-(void)onDidSelectCell{
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.number];
    NSLog(@"Calling number... %@", phoneNumber);

    BOOL opened = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    NSLog(@"Opened... %d", opened);

}

-(void) bindToUITableViewCell:(UITableViewCell *)cell{
    PhoneNumberCell* phoneCell = (PhoneNumberCell*) cell;
    phoneCell.nameLabel.text = [@"Call " stringByAppendingString:self.name];
}

@end
