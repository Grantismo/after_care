//
//  UIColor+AfterCareColors.h
//  AfterCare
//
//  Created by Lucas Best on 7/21/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

@interface UIColor (AfterCareColors)

+(UIColor*) afterCareOffWhiteColor;
+(UIColor*) afterCareOffBlackColor;

+(UIColor*) lonelyColor;
+(UIColor*) angryColor;
+(UIColor*) depressedColor;
+(UIColor*) hurtColor;
+(UIColor*) positiveColor;
+(UIColor*) gratefulColor;
+(UIColor*) disinterestedColor;
+(UIColor*) worthlessColor;
+(NSArray*) complementingColors: (UIColor*) color;

+(UIColor*) afterCareTransparentColor1;
+(UIColor*) afterCareTransparentColor2;
+(UIColor*) afterCareTransparentColor3;
+(UIColor*) afterCareTransparentColor4;
+(UIColor*) afterCareTransparentColor5;
+(UIColor*) afterCareTransparentColor6;
+(UIColor*) afterCareTransparentColor7;
+(UIColor*) afterCareTransparentColor8;

+ (UIColor*)changeBrightness:(UIColor*)color amount:(CGFloat)amount;

+ (UIColor*)addBrightness:(UIColor*)color amount:(CGFloat)amount;

@end
