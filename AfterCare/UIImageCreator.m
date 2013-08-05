//
//  SolidColorUIImageCreator.m
//  SuicidePrevention
//
//  Created by Lucas Best on 7/19/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "UIImageCreator.h"

#import <QuartzCore/QuartzCore.h>

#define EDGE_PADDING 1.0

@interface UIImageCreator ()

+(UIImage*) createImageFromContext:(CGContextRef) context;

@end

@implementation UIImageCreator

+(UIImage*) onePixelImageForColor:(UIColor *)color{
    CGSize oneSize = CGSizeMake(1.0, 1.0);
    
    if (UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(oneSize, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(oneSize);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0.0, 0.0, 1.0, 1.0));
    
    return [self createImageFromContext:context];
}

+(UIImage*) hexagonImageWithSize:(CGSize) size borderWidth:(float)borderWidth borderColorOffset:(float)borderColorOffset andColor:(UIColor *)color{
    if (UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const float* colors = CGColorGetComponents(color.CGColor);
    CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], colors[3]);
    
    // Drawing with a white stroke color
    CGContextSetRGBStrokeColor(context, colors[0] + borderColorOffset, colors[1] + borderColorOffset, colors[2] + borderColorOffset, colors[3]);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, borderWidth);
    
    float sizeWithBorderOffset = (size.width / 2.0) - (borderWidth / 1.75);
    
    // Now add the hexagon to the current path
    CGPoint point = CGPointMake(size.width / 2.0, size.height / 2.0);
    CGContextMoveToPoint(context, point.x + sizeWithBorderOffset, point.y);
    for(int i = 1; i < 6; i++)
    {
        CGFloat x = sizeWithBorderOffset * cosf(i * 2.0 * M_PI / 6.0);
        CGFloat y = sizeWithBorderOffset * sinf(i * 2.0 * M_PI / 6.0);
        CGContextAddLineToPoint(context, point.x + x, point.y + y);
    }
    
    // And close the subpath.
    CGContextClosePath(context);
    
    // Now draw the hexagon with the current drawing mode.
    CGContextDrawPath(context, kCGPathFillStroke);
    
    return [self createImageFromContext:context];
}

+(UIImage*) arrowImageWithSize:(CGSize)size andArrowSize:(CGSize)arrowSize andArrowWidthRatio:(float)ratio andColor:(UIColor *)color{
    if (UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat rectHeight = size.height - arrowSize.height;
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0.0, 0.0, size.width, rectHeight));
    
    CGFloat startPointX = (size.width * ratio) - (arrowSize.width / 2.0);
    CGContextMoveToPoint(context, startPointX, rectHeight);
    
    CGFloat midPointX = (size.width * ratio);
    CGContextAddLineToPoint(context, midPointX, size.height);
    
    CGFloat endPointX = (size.width * ratio) + (arrowSize.width / 2.0);
    CGContextAddLineToPoint(context, endPointX, rectHeight);
    
    // And close the subpath.
    CGContextClosePath(context);
    CGContextFillPath(context);
    
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
