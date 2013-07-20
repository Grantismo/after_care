//
//  SolidColorUIImageCreator.h
//  SuicidePrevention
//
//  Created by Lucas Best on 7/19/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageCreator : NSObject

+(UIImage*) onePixelImageForColor:(UIColor*) color;

+(UIImage*) hexagonImageWithSize:(CGSize) size andColor:(UIColor*) color;

@end
