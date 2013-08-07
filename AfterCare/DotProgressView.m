//
//  DotProgressView.m
//  AfterCare
//
//  Created by Lucas Best on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "DotProgressView.h"

@interface DotProgressView ()

-(void) privateDotProgressViewInit;

-(void) resetImages;

@end

@implementation DotProgressView

-(void) privateDotProgressViewInit{
    activatedArray = [[NSMutableArray alloc] init];
    imageViewArray = [[NSMutableArray alloc] init];
    
    self.backgroundColor = [UIColor clearColor];
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self privateDotProgressViewInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self privateDotProgressViewInit];
    }
    return self;
}

-(void) layoutSubviews{
    float frameWidth = self.frame.size.width;
    float frameHeight = self.frame.size.height;
    
    int stepSize = frameWidth / (float)(imageViewArray.count + 1);
    
    for (int i = 0; i < imageViewArray.count; i++) {
        UIImageView* imageView = [imageViewArray objectAtIndex:i];
        
        imageView.frame = CGRectMake(((i+1) * stepSize) - (frameHeight / 2.0), 0.0, frameHeight, frameHeight);
    }
}

#pragma mark public methods

-(void) addDot:(BOOL)active{
    [activatedArray addObject:[NSNumber numberWithBool:active]];
    
    UIImageView* newImageView = [[UIImageView alloc] initWithImage:(active ? self.activatedDotImage : self.deactivatedDotImage)];
    [imageViewArray addObject:newImageView];
    
    [self addSubview:newImageView];
}

-(void) setDotActivatedAtIndex:(int)index{
    if (index >= 0 && index < [activatedArray count]){
        [activatedArray replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:FALSE]];
        UIImageView* imageView = [imageViewArray objectAtIndex:index];
        imageView.image = self.activatedDotImage;
    }
    else{
        NSLog(@"Cannot set dot active at %d, value must be between 0 and %d", index, activatedArray.count);
    }
}

-(void) setDotDeactivatedAtIndex:(int)index{
    if (index >= 0 && index < [activatedArray count]){
        [activatedArray replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:TRUE]];
        UIImageView* imageView = [imageViewArray objectAtIndex:index];
        imageView.image = self.deactivatedDotImage;
    }
    else{
        NSLog(@"Cannot set dot inactive at %d, value must be between 0 and %d", index, activatedArray.count);
    }
}

#pragma mark property setters

-(void) setNumberOfDots:(int)numberOfDots{
    _numberOfDots = numberOfDots;
    
    [activatedArray removeAllObjects];
    for (int i = 0; i < numberOfDots; i++) {
        [activatedArray addObject:[NSNumber numberWithBool:FALSE]];
        
        UIImageView* newImageView = [[UIImageView alloc] initWithImage:self.deactivatedDotImage];
        [imageViewArray addObject:newImageView];
        
        [self addSubview:newImageView];
    }
    
    [self setNeedsLayout];
}

-(void) setActivatedDotImage:(UIImage *)activatedDotImage{
    _activatedDotImage = activatedDotImage;
    
    [self resetImages];
}

-(void) setDeactivatedDotImage:(UIImage *)deactivatedDotImage{
    _deactivatedDotImage = deactivatedDotImage;
    
    [self resetImages];
}

#pragma mark private methods

-(void) resetImages{
    for (int i = 0; i < imageViewArray.count; i++) {
        UIImageView* imageView = [imageViewArray objectAtIndex:i];
        BOOL isActive = [[activatedArray objectAtIndex:i] boolValue];
        
        if (isActive){
            imageView.image = self.activatedDotImage;
        }
        else{
            imageView.image = self.deactivatedDotImage;
        }
    }
}

@end
