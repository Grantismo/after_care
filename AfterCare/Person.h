//
//  Person.h
//  AfterCare
//
//  Created by Lucas Best on 8/7/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* phoneNumber;

@end
