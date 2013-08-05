//
//  StyleManager.h
//  AfterCare
//
//  Created by Lucas Best on 8/5/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OPEN_SANS_LIGHT @"OpenSans-Light"
#define OPEN_SANS_BOLD @"OpenSans-Bold"
#define OPEN_SANS_EXTRA_BOLD @"OpenSans-Extrabold"
#define OPEN_SANS_ITALIC @"OpenSans-Italic"


@interface StyleManager : NSObject

-(void) initialize;
-(void) setLightFontForLabel:(UILabel*) label;
-(void) setBoldFontForLabel:(UILabel*) label;
-(void) setItalicFontForLabel:(UILabel*) label;

-(void) appendTitleTextAttributes:(NSDictionary*) titleTextAttributes toNavigationBar:(UINavigationBar*) navbar;


+(StyleManager*) sharedStyleManager;

@end
