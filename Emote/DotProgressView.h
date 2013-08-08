//
//  DotProgressView.h
//  AfterCare
//
//  Created by Lucas Best on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DotProgressView : UIView{
    NSMutableArray* activatedArray;
    NSMutableArray* imageViewArray;
}

@property (nonatomic) int numberOfDots;

@property (nonatomic, strong) UIImage* activatedDotImage;
@property (nonatomic, strong) UIImage* deactivatedDotImage;

-(void) addDot:(BOOL) active;
-(void) setDotActivatedAtIndex:(int) index;
-(void) setDotDeactivatedAtIndex:(int) index;

@end
