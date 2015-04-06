//
//  WelcomeViewController.m
//  iOSStudy
//
//  Created by chenguandong on 15/4/3.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "WelcomeViewController.h"
#import <SVProgressHUD.h>
#import "NetWorkTools.h"
#import "HttpVersionTools.h"
#import "MainTabBarViewController.h"
#import <SVProgressHUD.h>
#import "VersionBean.h"
@interface WelcomeViewController ()

@end

@implementation WelcomeViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSLog(@"------checkNetworking");
    
    [SVProgressHUD show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //获取服务器HTTP当前版本号
    SharedApp.isNetworking = YES;
    [HttpVersionTools getVersions:^(NSArray *versionLists) {
        SharedApp.versionLists = versionLists;
        
        for (VersionBean *vBean in SharedApp.versionLists) {
            NSLog(@"version =%@",vBean.urlVersion);
        }
        
        [self goNextPage];
    } v_error:^{
        [self goNextPage];
    } v_netWork:^(BOOL isNetWorking) {
        [self goNextPage];
    }];
}

-(void)goNextPage{
    [self performSegueWithIdentifier:@"mainTab" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
