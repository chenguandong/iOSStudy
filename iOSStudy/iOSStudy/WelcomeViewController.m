//
//  WelcomeViewController.m
//  iOSStudy
//
//  Created by chenguandong on 15/4/3.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "WelcomeViewController.h"
#import "NetWorkTools.h"
#import "HttpVersionTools.h"
#import "MainTabBarViewController.h"
#import "VersionBean.h"
#import "NotificationCenterConstants.h"
@interface WelcomeViewController ()

@end

@implementation WelcomeViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

      [_animationImageView startAnimating];
    
    


}

-(void)versionSuccess:(NSNotification*)notifacation{
    [self goNextPage];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(versionSuccess:) name:notifacationVersionSuccess object:nil];
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:20];
    for (int i =1; i<21; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"anim_%.2d.png",i];
        
        [imageArray addObject:[UIImage imageNamed:imageName]];
    }
    
    
    _animationImageView.animationImages = imageArray;
    _animationImageView.animationRepeatCount = 0;
    _animationImageView.animationDuration = 10;
    
    
    
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:_shinmmerView.bounds];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.font =[UIFont systemFontOfSize:40];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = NSLocalizedString(@"loadData", nil);
    
    _shinmmerView.contentView = loadingLabel;
    
    // Start shimmering.
    _shinmmerView.shimmering = YES;
}

-(void)goNextPage{
    [self performSegueWithIdentifier:@"mainTab" sender:self];
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [_animationImageView stopAnimating];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:notifacationVersionSuccess object:nil];
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
