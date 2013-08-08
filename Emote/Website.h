//
//  Website.h
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellDataProvider.h"
#import "CellDataProviderBase.h"

@interface Website : CellDataProviderBase <CellDataProvider>

@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* descript;
@property (nonatomic, strong) NSString* imageUrl;
@property (nonatomic, strong) UIColor* color;


@end
