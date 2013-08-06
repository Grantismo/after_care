//
//  DataManager.m
//  AfterCare
//
//  Created by Lucas Best on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager{
    NSString* documentDirectory;
}

-(id) init{
    self = [super init];
    if (self){
        NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentDirectory = [[NSString alloc] initWithString:[documentDirectories objectAtIndex:0]];
    }
    return self;
}

-(void) writeObject:(id<NSCoding>)object toFile:(NSString *)file{
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:file];
    [NSKeyedArchiver archiveRootObject:object toFile:filePath];
}

-(void) writeBoolean:(BOOL)boolean toFile:(NSString *)file{
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:file];
    [NSKeyedArchiver archiveRootObject:[NSNumber numberWithBool:boolean] toFile:filePath];
}

-(void) writeInt:(int)integer toFile:(NSString *)file{
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:file];
    [NSKeyedArchiver archiveRootObject:[NSNumber numberWithInt:integer] toFile:filePath];
}

-(id) readObjectFromFile:(NSString *)file{
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:file];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

-(BOOL) readBOOLFromFile:(NSString *)file{
    return [[self readObjectFromFile:file] boolValue];
}

-(int) readIntFromFile:(NSString*) file{
    return [[self readObjectFromFile:file] intValue];
}

+(DataManager*) sharedDataManager{
    static DataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
    });
    return sharedInstance;
}

@end
