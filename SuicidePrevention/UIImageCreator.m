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

-(void)drawInContext:(CGContextRef)context
{
    // Drawing with a white stroke color
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    // Drawing with a blue fill color
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    CGPoint center;
    
    // Now add the hexagon to the current path
    center = CGPointMake(210.0, 90.0);
    CGContextMoveToPoint(context, center.x, center.y + 60.0);
    for(int i = 1; i < 6; ++i)
    {
        CGFloat x = 60.0 * sinf(i * 2.0 * M_PI / 6.0);
        CGFloat y = 60.0 * cosf(i * 2.0 * M_PI / 6.0);
        CGContextAddLineToPoint(context, center.x + x, center.y + y);
    }
    // And close the subpath.
    CGContextClosePath(context);
    
    // Now draw the star & hexagon with the current drawing mode.
    CGContextDrawPath(context, self.drawingMode);
}

@end
