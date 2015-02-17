//
//  AppDelegate.m
//  iOSStudy
//
//  Created by chenguandong on 15/1/29.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "AppDelegate.h"
#import "NetWorkTools.h"
#import "Reachability.h"
#import <SVProgressHUD.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self checkNetworking];
    
    return YES;
}

-(void)checkNetworking{
    
    
    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        // keep in mind this is called on a background thread
        // and if you are updating the UI it needs to happen
        // on the main thread, like this:
        
        NSLog(@"网络已经连接!");
        
        _isNetworking = YES;
    
        
        [SVProgressHUD dismiss];
        
        
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"网络断开!");
        
        
        
        _isNetworking = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showErrorWithStatus:@"无网络连接" maskType:SVProgressHUDMaskTypeGradient];
            
            double delayInSeconds = 2.0; dispatch_time_t
            popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // code to be executed on the main queue after delay
                
                [SVProgressHUD dismiss];
            });
        });
        
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
