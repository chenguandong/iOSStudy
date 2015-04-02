//
//  NetWorkTools.m
//  iOSStudy
//
//  Created by chenguandong on 15/1/31.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "NetWorkTools.h"
#import <SVProgressHUD.h>
#import "Reachability.h"
@implementation NetWorkTools


+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}


+(void)postHttp:(NSString*)httpUrl success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking{

    if (SharedApp.isNetworking) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        [manager POST:httpUrl parameters:nil success:success failure:error];
    }else{
     
        isNetworking(false);
        
        NSLog(@"REACHABLE!");
        [SVProgressHUD showErrorWithStatus:@"无网络连接" maskType:SVProgressHUDMaskTypeGradient];
        
        double delayInSeconds = 3.0; dispatch_time_t
        popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // code to be executed on the main queue after delay
            [SVProgressHUD dismiss];
        });
        
        
    }
}


+(void)checkNetworking{
    
    
    
    
    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"http://www.baidu.com"];
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        // keep in mind this is called on a background thread
        // and if you are updating the UI it needs to happen
        // on the main thread, like this:
        
        NSLog(@"网络已经连接!");
        
        
        SharedApp.isNetworking = YES;
        
        [SVProgressHUD dismiss];
        
        
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
                
                [SVProgressHUD dismiss];
            });
        });
        
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
    
    
    
}




@end
