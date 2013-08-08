//
//  ColorTintImageView.h
//  AfterCare
//
//  Created by Lucas Best on 8/5/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorTintImageView : UIView

@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) UIColor* overlayColor;


- (void) setOverlayColor:(UIColor *)newColor;

@end
