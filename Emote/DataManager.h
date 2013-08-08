//
//  DataManager.h
//  AfterCare
//
//  Created by Lucas Best on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

@interface DataManager : NSObject

-(void) writeObject:(id<NSCoding>) object toFile:(NSString*) file;
-(void) writeBoolean:(BOOL) boolean toFile:(NSString*) file;
-(void) writeInt:(int) integer toFile:(NSString*) file;

-(id) readObjectFromFile:(NSString*) file;
-(BOOL) readBOOLFromFile:(NSString*) file;
-(int) readIntFromFile:(NSString*) file;

+(DataManager*) sharedDataManager;

@end
