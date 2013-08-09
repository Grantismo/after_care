//
//  UIColor+AfterCareColors.m
//  AfterCare
//
//  Created by Lucas Best on 7/21/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "UIColor+AfterCareColors.h"

@implementation UIColor (AfterCareColors)

+(UIColor*) afterCareOffWhiteColor{
    return UIColorFromRGB(0xeaeae5, 1.0);
}

+(UIColor*) afterCareOffBlackColor{
    return UIColorFromRGB(0x2b2823, 1.0);
}

+(UIColor*) lonelyColor{
    return UIColorFromRGB(0x95dc8c, 1.0);
}

+(UIColor*) angryColor{
    return UIColorFromRGB(0xcbd6b4, 1.0);
}

+(UIColor*) depressedColor{
    return UIColorFromRGB(0xefca16, 1.0);
}

+(UIColor*) hurtColor{
    return UIColorFromRGB(0x40898b, 1.0);
}

+(UIColor*) positiveColor{
    return UIColorFromRGB(0xcb7522, 1.0);
}

+(UIColor*) gratefulColor{
    return UIColorFromRGB(0x66c0a0, 1.0);
}

+(UIColor*) disinterestedColor{
    return [UIColor addBrightness:UIColorFromRGB(0x583f22, 1.0) amount:.2];
}

+(UIColor*) worthlessColor{
    return UIColorFromRGB(0xeba207, 1.0);
}


+(NSArray*) complementingColors: (UIColor*) color{
    NSMutableArray* allColors = [NSMutableArray arrayWithObjects:[self worthlessColor], [self disinterestedColor], [self gratefulColor], [self positiveColor], [self hurtColor], [self depressedColor], [self angryColor], [self lonelyColor], nil];
    [allColors removeObject:color];
    return allColors;
}

//Transparent colors

+(UIColor*) afterCareTransparentColor1{
    return [self changeBrightness:[self lonelyColor] amount:1.5];
}

+(UIColor*) afterCareTransparentColor2{
    return [self changeBrightness:[self angryColor] amount:1.5];
}

+(UIColor*) afterCareTransparentColor3{
    return [self changeBrightness:[self depressedColor] amount:1.5];
}
+(UIColor*) afterCareTransparentColor4{
    return [self changeBrightness:[self hurtColor] amount:1.5];
}

+(UIColor*) afterCareTransparentColor5{
    return [self changeBrightness:[self positiveColor] amount:1.5];
}

+(UIColor*) afterCareTransparentColor6{
    return [self changeBrightness:[self gratefulColor] amount:1.5];
}

+(UIColor*) afterCareTransparentColor7{
    return [self changeBrightness:[self disinterestedColor] amount:1.5];
}

+(UIColor*) afterCareTransparentColor8{
    return [self changeBrightness:[self worthlessColor] amount:1.5];
}

+ (UIColor*)changeBrightness:(UIColor*)color amount:(CGFloat)amount{
    CGFloat hue, saturation, brightness, alpha;
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        brightness += (amount-1.0);
        brightness = MAX(MIN(brightness, 1.0), 0.0);
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    }
    
    CGFloat white;
    if ([color getWhite:&white alpha:&alpha]) {
        white += (amount-1.0);
        white = MAX(MIN(white, 1.0), 0.0);
        return [UIColor colorWithWhite:white alpha:alpha];
    }
    
    return nil;
}

+ (UIColor*)addBrightness:(UIColor*)color amount:(CGFloat)amount{
    CGFloat r, g, b, a;
    if ([color getRed:&r green:&g blue:&b alpha:&a]){
        r += amount;
        g += amount;
        b += amount;
        
        r = MAX(MIN(r, 1.0), 0.0);
        g = MAX(MIN(g, 1.0), 0.0);
        b = MAX(MIN(b, 1.0), 0.0);
        
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    
    CGFloat white;
    if ([color getWhite:&white alpha:&a]) {
        white += amount;
        white = MAX(MIN(white, 1.0), 0.0);
        return [UIColor colorWithWhite:white alpha:a];
    }
    
    return nil;
}

@end
