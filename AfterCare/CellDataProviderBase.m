//
//  CellDataProviderBase.m
//  AfterCare
//
//  Created by Grant Warman on 7/20/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "CellDataProviderBase.h"
#import "CellFactory.h"


@implementation CellDataProviderBase
@synthesize reuseIdentifier;
@synthesize delegate;
@synthesize staticCellHeight;
@dynamic emotions;


- (id) initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self != nil) {
        self.reuseIdentifier = [NSStringFromClass(self.class) stringByAppendingString:@"Cell"];
        self.staticCellHeight = [self newUITableViewCell].frame.size.height;
    }
    return self;
}


-(UITableViewCell*) newUITableViewCell{
    return [CellFactory UITableViewCellFromNibNamed:self.reuseIdentifier];
}

-(CGFloat)cellHeight{
    return self.staticCellHeight;
}

- (NSMutableString *)titleWithNewLine: (NSString*) title {
    NSArray *titleWords = [title componentsSeparatedByString: @" "];
    NSMutableString* titleString = [NSMutableString stringWithString:@""];
    int charCount = 0;
    BOOL addedNewLine = NO;
    for(int i = 0; i < titleWords.count; i++){
        NSString* titleWord = titleWords[i];
        charCount += titleWord.length;
        if((charCount > 18) && (title.length > 24) && !addedNewLine){
            [titleString appendString:@"\n          "];
            addedNewLine = YES;
        }else if(i > 0){
            [titleString appendString:@" "];
        }
        [titleString appendString:titleWord];
    }
    return titleString;
}



@end
