//
//  SolidColorUIImageCreator.m
//  SuicidePrevention
//
//  Created by Lucas Best on 7/19/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "UIImageCreator.h"

#import <QuartzCore/QuartzCore.h>

@implementation UIImageCreator

+(UIImage*) onePixelImageForColor:(UIColor *)color{
    UIGraphicsBeginImageContext(CGSizeMake(1.0, 1.0));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0.0, 0.0, 1.0, 1.0));
    
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    UIImage* img = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    CGContextRelease(context);
    
    return img;
}

+(UIImage*) hexagonImageWithSize:(CGSize) size andColor:(UIColor*) color{
    
}

@end
