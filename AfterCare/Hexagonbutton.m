//
//  Hexagonbutton.m
//  AfterCare
//
//  Created by Lucas Best on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "Hexagonbutton.h"

@interface Hexagonbutton ()

-(void) setBackgroundImageFromProperties;

@end

@implementation Hexagonbutton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width * HEXAGON_WIDTH_HEIGHT_RATIO)];
    if (self) {
        self.color = [UIColor redColor];
        self.borderColorOffset = -.06;
        self.borderWidth = 10.0;
        
        [self setTitleColor:[UIColor afterCareOffWhiteColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
        
        self.autoresizingMask = UIViewAutoresizingNone;
        
        [self setBackgroundImageFromProperties];
    }
    return self;
}

#pragma mark property setters

-(void) setColor:(UIColor *)color{
    _color = color;
    
    [self setBackgroundImageFromProperties];
}

-(void) setBorderColorOffset:(float)borderColorOffset{
    _borderColorOffset = borderColorOffset;
    
    [self setBackgroundImageFromProperties];
}

-(void) setBorderWidth:(float)borderWidth{
    _borderWidth = borderWidth;
    
    [self setBackgroundImageFromProperties];
}

#pragma mark private methods

-(void) setBackgroundImageFromProperties{
    [self setBackgroundImage:[UIImageCreator hexagonImageWithSize:self.frame.size borderWidth:self.borderWidth borderColorOffset:self.borderColorOffset andColor:self.color] forState:UIControlStateNormal];
}

@end
