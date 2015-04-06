//
//  ThirdTableViewController.h
//  iOSStudy
//
//  Created by chenguandong on 15/2/10.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdViewControllerViewModel.h"
#import <SWTableViewCell.h>
@interface ThirdTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)ThirdViewControllerViewModel *viewModel;
@property(nonatomic,copy)NSString* favouriteType;
@end
