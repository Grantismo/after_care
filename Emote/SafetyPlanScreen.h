//
//  SafetyPlanScreen.h
//  AfterCare
//
//  Created by Lucas Best on 8/6/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "SafetyPlanManager.h"
#import "DotProgressView.h"

@interface SafetyPlanScreen : NSObject{
    IBOutlet UIButton* addButton1;
    IBOutlet UIButton* addButton2;
    IBOutlet UIButton* addButton3;
    IBOutlet UIButton* addButton4;
    
    IBOutlet UIImageView* detailImage1;
    IBOutlet UIImageView* detailImage2;
    IBOutlet UIImageView* detailImage3;
    IBOutlet UIImageView* detailImage4;
    
    IBOutlet DotProgressView* progressView;
}

-(NSString*) titleText;
-(NSString*) descriptionText;

-(void) addToView:(UIView*) view;
-(void) removeFromSuperview;
-(void) layoutViews;

-(void) animateIn;
-(void) animateOut;

-(IBAction)addToSafetyPlan:(UIButton*)sender;

//protected methods
-(NSString*) alertMessageInfoForTag:(int) tag;
-(NSString*) editAlertTitleForTag:(int) tag;

-(NSString*) editPlaceholderTextForTag:(int) tag;
-(NSString*) editPlaceholderText1ForTag:(int) tag;

-(NSString*) phoneNumberForTag:(int) tag;

-(UIAlertViewStyle) alertStyle;

-(BOOL) shouldEditForTag:(int) tag;
-(void) textWasEdited:(NSString*) text text1:(NSString*) text1 forTag:(int) tag;

-(void) refreshButtonsFromSafetyPlan;

@end
