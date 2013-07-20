//
//  SolidColorUIImageCreator.h
//  SuicidePrevention
//
//  Created by Lucas Best on 7/19/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageCreator : NSObject

+(UIImage*) onePixelImageForColor:(UIColor*) color;

+(UIImage*) hexagonImageWithSize:(CGSize) size borderWidth:(float) borderWidth andColor:(UIColor*) color;

@end
