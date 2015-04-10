//
//  MainTabBarViewController.m
//  iOSStudy
//
//  Created by chenguandong on 15/4/3.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "AppDelegate.h"
@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


/*
 
 -(void)pushBage{
 
 
 NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
 
 NSInteger i = [defalut integerForKey:@"bage"];
 i++;
 
 [defalut setInteger:i forKey:@"bage"];
 
 [defalut synchronize];
 
 [[UIApplication sharedApplication]setApplicationIconBadgeNumber:i];
 }
 */


@end
