//
//  SolidColorUIImageCreator.m
//  SuicidePrevention
//
//  Created by Lucas Best on 7/19/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "UIImageCreator.h"

#import <QuartzCore/QuartzCore.h>

@interface UIImageCreator ()

+(UIImage*) createImageFromContext:(CGContextRef) context;

@end

@implementation UIImageCreator

+(UIImage*) onePixelImageForColor:(UIColor *)color{
    UIGraphicsBeginImageContext(CGSizeMake(1.0, 1.0));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0.0, 0.0, 1.0, 1.0));
    
    return [self createImageFromContext:context];
}

+(UIImage*) hexagonImageWithSize:(CGSize) size borderWidth:(float)borderWidth andColor:(UIColor *)color{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Drawing with a white stroke color
    CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
    
    const float* colors = CGColorGetComponents(color.CGColor);
    CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], colors[3]);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, borderWidth);
    
    
    CGContextMoveToPoint(context, size.width * .25, borderWidth);
    
    CGContextAddLineToPoint(context, size.width * .75, borderWidth);
    CGContextAddLineToPoint(context, size.width - borderWidth, size.height * .5);
    CGContextAddLineToPoint(context, size.width * .75, size.height - borderWidth);
    CGContextAddLineToPoint(context, size.width * .25, size.height - borderWidth);
    CGContextAddLineToPoint(context, borderWidth, size.height * .5);
    
    CGContextClosePath(context);
    
    // Now draw the hexagon with the current drawing mode.
    CGContextDrawPath(context, kCGPathFillStroke);
    
    return [self createImageFromContext:context];
}

+(UIImage*) createImageFromContext:(CGContextRef)context{
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    UIImage* img = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    CGContextRelease(context);
    
    return img;
}

@end
