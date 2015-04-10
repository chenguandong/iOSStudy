//
//  WelcomeTools.m
//  iOSStudy
//
//  Created by chenguandong on 15/4/10.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "WelcomeTools.h"
#import "HttpVersionTools.h"
#import "Constants .h"
#import "NetWorkTools.h"
#import <SVProgressHUD.h>
#import "Reachability.h"
#import "NotificationCenterConstants.h"
@implementation WelcomeTools
{

}
+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        
        [self initNetWork];
        
    });
    return sharedInstance;
}


+(void)initNetWork{
    // Allocate a reachability object
    reach = [Reachability reachabilityWithHostname:@"www.douban.com"];
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        // keep in mind this is called on a background thread
        // and if you are updating the UI it needs to happen
        // on the main thread, like this:
        
        NSLog(@"网络已经连接!");
        
        
        SharedApp.isNetworking = YES;
        
        [SVProgressHUD dismiss];
        
        if (!SharedApp.versionLists) {
            [self regetHttpVersion];
        }
        
        
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"网络断开!");
        
        SharedApp.isNetworking = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showErrorWithStatus:@"无网络连接" maskType:SVProgressHUDMaskTypeGradient];
            
            double delayInSeconds = 2.0;
            dispatch_time_t
            popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // code to be executed on the main queue after delay
                 [self sendVersionSuccess];
                [SVProgressHUD dismiss];
            });
        });
        
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
    
    
    
}

-(void)dealloc{
    [reach stopNotifier];
}

+(void)regetHttpVersion{
    //获取服务器HTTP当前版本号

    [HttpVersionTools getVersions:^(NSArray *versionLists) {
        SharedApp.versionLists = versionLists;
        [self sendVersionSuccess];
    } v_error:^{
        [self sendVersionSuccess];
    } v_netWork:^(BOOL isNetWorking) {
        [self sendVersionSuccess];
    }];
}

+(void)sendVersionSuccess{
     [[NSNotificationCenter defaultCenter]postNotificationName:notifacationVersionSuccess object:nil userInfo:nil];
}

@end
