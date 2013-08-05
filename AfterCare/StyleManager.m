//
//  StyleManager.m
//  AfterCare
//
//  Created by Lucas Best on 8/5/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "StyleManager.h"

@implementation StyleManager

-(id) init{
    self = [super init];
    if (self){
        [[UINavigationBar appearance] setTitleTextAttributes:@{
                                        UITextAttributeFont : [UIFont boldSystemFontOfSize:15.0],
                            UITextAttributeTextShadowOffset : [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)]}];
    }
    return self;
}

-(void) initialize{
    //do nothing.
}

-(void) setLightFontForLabel:(UILabel *)label{
    label.font = [UIFont fontWithName:OPEN_SANS_LIGHT size:label.font.pointSize];
}

-(void) setBoldFontForLabel:(UILabel *)label{
    label.font = [UIFont fontWithName:OPEN_SANS_BOLD size:label.font.pointSize];
}

-(void) setItalicFontForLabel:(UILabel *)label{
    label.font = [UIFont fontWithName:OPEN_SANS_ITALIC size:label.font.pointSize];
}

-(void) appendTitleTextAttributes:(NSDictionary *)titleTextAttributes toNavigationBar:(UINavigationBar *)navbar{
    NSMutableDictionary* mutableDict = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    
    for (id key in [titleTextAttributes allKeys]) {
        [mutableDict setObject:[titleTextAttributes objectForKey:key] forKey:key];
    }
    
    [navbar setTitleTextAttributes:mutableDict];
}

+(StyleManager*) sharedStyleManager{
    static StyleManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[StyleManager alloc] init];
    });
    return sharedInstance;
}

@end
