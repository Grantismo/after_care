//
//  ColorTintImageView.m
//  AfterCare
//
//  Created by Lucas Best on 8/5/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "ColorTintImageView.h"

@implementation ColorTintImageView

-(void) setImage:(UIImage *)image{
    _image = image;
    
    [self setNeedsDisplay];
}

- (void) setOverlayColor:(UIColor *)newColor{
    _overlayColor = newColor;
    
    [self setNeedsDisplay]; // fires off drawRect each time color changes
}

- (void) drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // Draw picture first
    
    [self.image drawInRect:rect];
    
    // Blend mode could be any of CGBlendMode values. Now draw filled rectangle
    // over top of image.
    //
    CGContextSetBlendMode (context, kCGBlendModeMultiply);
    CGContextSetFillColor(context, CGColorGetComponents(self.overlayColor.CGColor));
    CGContextFillRect (context, rect);
    CGContextRestoreGState(context);
}

@end
