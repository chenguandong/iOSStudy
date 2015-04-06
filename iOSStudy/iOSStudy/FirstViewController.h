//
//  FirstViewController.h
//  iOSStudy
//
//  Created by chenguandong on 15/1/29.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FirstViewControllerViewModel.h"
#import <SWTableViewCell.h>
@interface FirstViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)FirstViewControllerViewModel *viewModel;
@property(nonatomic,copy)NSString *favouriteType ;
-(void)initViewData;

/**
 *  停止UITableView刷新
 */
-(void)stopTableRefreshing;
@end

