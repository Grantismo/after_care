 //
//  AppDelegate.m
//  SuicidePrevention
//
//  Created by Lucas Best on 7/19/13.
//  Copyright (c) 2013 TabSprint. All rights reserved.
//

#import "AppDelegate.h"

#import "HexagonMainViewController.h"
#import "ResourcesViewController.h"
#import <CoreData/CoreData.h>
#import "Website.h"
#import "PhoneNumber.h"
#import "Website.h"
#import "Emotion.h"

#import "StyleManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self seedCoreDataIfEmpty];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    HexagonMainViewController* hex = [[HexagonMainViewController alloc] initWithNibName:NSStringFromClass([HexagonMainViewController class]) bundle:nil];
    
    
    
    
    hex.managedObjectContext = self.managedObjectContext;
    self.viewController = hex;

   // self.viewController = [[ResourcesViewController alloc] initWithNSManagedObjectContext:self.managedObjectContext];
    
    [[StyleManager sharedStyleManager] initialize];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AfterCareDataModel" ofType:@"momd"];
    NSURL *momURL = [NSURL fileURLWithPath:path];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
    
    return _managedObjectModel;

}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"AfterCare.sqlite"]];
    NSError *error = nil;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
    						 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
    						 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil URL:storeUrl options:options error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)dealloc
{
    _managedObjectModel = nil;
    _managedObjectContext = nil;
    _persistentStoreCoordinator = nil;
}

- (BOOL)coreDataHasEntriesForEntityName:(NSString *)entityName {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    [request setFetchLimit:1];
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if ([results count] == 0) {
        return NO;
    }
    return YES;
}

- (void) seedCoreDataIfEmpty{
    if(![self coreDataHasEntriesForEntityName:@"Emotion"]){
        NSDictionary *emotionDict = @{@"positive": @0xcb7522, @"angry": @0xcbd6b4, @"lonely": @0x95dc8c, @"depressed": @0xefca16, @"hurt": @0x40898b, @"grateful": @0x66c0a0, @"worthless": @0xeba2071, @"disinterested": @0x583f22};
        
        for(NSString* key in emotionDict){
            NSString* name = key;
            UIColor* color = UIColorFromRGB([[emotionDict objectForKey:key] integerValue], 1.0);
            Emotion* emotion = (Emotion*)[NSEntityDescription
                                    insertNewObjectForEntityForName:@"Emotion"inManagedObjectContext:self.managedObjectContext];
            emotion.name = name;
            emotion.color = color;
        }
        
        PhoneNumber *number = (PhoneNumber*)[NSEntityDescription
                   insertNewObjectForEntityForName:@"PhoneNumber"inManagedObjectContext:self.managedObjectContext];
        
        number.name = @"NATIONAL SUICIDE PREVENTION LIFELINE";
        number.descript = @"No matter what problems you are dealing with we can help.";
        number.number = @"1-800-273-8255";
        
        number.emotions = [NSSet setWithArray:[Emotion fetchWithNames:@"ALL" fromManagedObjectContext:self.managedObjectContext]];
        
        NSLog(@"emotions : %d", number.emotions.count);


        
        NSError* err = nil;
        NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"resources" ofType:@"json"];
        NSArray* resources = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath]
                                                                 options:kNilOptions
                                                                   error:&err];
        for(id obj in resources){
            Website *site = (Website*)[NSEntityDescription
                                                 insertNewObjectForEntityForName:@"Website"inManagedObjectContext:self.managedObjectContext];
            site.title = [obj objectForKey:@"title"];
            NSLog(@"title : %@", site.title);
            site.url = [obj objectForKey:@"link"];
            site.descript = [obj objectForKey:@"description"];
            site.emotions = [NSSet setWithArray:[Emotion fetchWithNames: [obj objectForKey:@"emotions"] fromManagedObjectContext:self.managedObjectContext]];
            NSLog(@"emotions : %d", site.emotions.count);

        }
        
        
        [self.managedObjectContext save:nil];
        
        

      
//        
//       
////        number.name = @"SUICIDE ANONYMOUS";
////        number.number = @"2486223655";
////        number.descript = @"Suicideanonymous.net is a website that provides resources that provide worldwide Skype meetings and other support systems.";
////        number.color = [UIColor depressedColor];

    }
    



}

@end
