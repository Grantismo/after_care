//
//  PhoneNumber.h
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellDataProvider.h"
#import "CellDataProviderBase.h"

@interface PhoneNumber : CellDataProviderBase <CellDataProvider>
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* number;

@end
