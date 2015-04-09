//
//  FirstViewController.h
//  iOSStudy
//
//  Created by chenguandong on 15/1/29.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BlogViewControllerViewModel.h"
#import <SWTableViewCell.h>
@interface BlogViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)BlogViewControllerViewModel *viewModel;
@property(nonatomic,copy)NSString *favouriteType ;
-(void)initViewData;

/**
 *  停止UITableView刷新
 */
-(void)stopTableRefreshing;
@end

