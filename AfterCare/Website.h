//
//  Website.h
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellDataSource.h"

@interface Website : NSObject<CellDataSource>

@property (nonatomic, strong) NSURL* url;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, strong) NSURL* imageUrl;

@end
