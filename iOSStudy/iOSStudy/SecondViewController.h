//
//  SecondViewController.h
//  iOSStudy
//
//  Created by chenguandong on 15/1/29.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SecondViewControllerViewModel.h"
#import <SWTableViewCell.h>
@interface SecondViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)SecondViewControllerViewModel *viewModel;
@property(nonatomic,copy)NSString *favouriteType;
@end

