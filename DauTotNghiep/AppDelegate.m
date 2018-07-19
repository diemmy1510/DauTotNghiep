//
//  AppDelegate.m
//  DauTotNghiep
//
//  Created by 507-0 on 2/20/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "AppDelegate.h"


@import GoogleMobileAds;
@import Firebase;
@interface AppDelegate ()<MonHocControllerDelegate, DeThiControllerDelegate, MessageControllerDelegate>
@property (nonatomic, strong) NSArray *arr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [FIRApp configure];
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-3858269241810873~6577259142"];
   
    [[MonHocController getInstance] addDelegate:self];
    [[DeThiController getInstance] addDelegate:self];
    [[APIController shareInstance] addDelegate:self];
    [[APIController shareInstance] getTimeUpdate];
    
    return YES;
}
-(void)didRequestListSubjects:(NSArray *)arrSubjects taskRequest:(NSURLSessionDataTask *)taskRequest error:(NSError *)error errorObject:(id)errorObject{
    self.arr = arrSubjects;
    [[DeThiController getInstance] getTest];
}
-(void)didRequestListTests:(NSArray *)arrTests taskRequest:(NSURLSessionDataTask *)taskRequest error:(NSError *)error errorObject:(id)errorObject{
    [[DataManager sharedInstance] deleteAllMonHoc];
    [[DataManager sharedInstance] deleteAllDeThi];
    [[DataManager sharedInstance] insertSubjects: self.arr];
    [[DataManager sharedInstance] insertTest:arrTests];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"load10DeTop" object:[DataManager sharedInstance]];
}
-(void)didRequestTimeUpdate: (NSDate *)timeUpdate taskRequest: (NSURLSessionDataTask *)taskRequest error: (NSError *)error errorObject: (id)errorObject{
    NSDate *timeUpdated = [DataManager sharedInstance].setTimeUpdate;
    if (timeUpdated != timeUpdate) {
        //lay lai data tu server
        [[MonHocController getInstance] getSubjects];
        [DataManager sharedInstance].setTimeUpdate = timeUpdate;
    }
    else{
        [[DataManager sharedInstance] getAllSubjects];
    }

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
