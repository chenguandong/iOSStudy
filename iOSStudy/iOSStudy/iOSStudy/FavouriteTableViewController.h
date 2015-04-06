//
//  FavouriteTableViewController.h
//  iOSStudy
//
//  Created by chenguandong on 15/4/6.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavouriteViewControllerViewModel.h"
@interface FavouriteTableViewController : UITableViewController
@property(nonatomic,strong)FavouriteViewControllerViewModel * viewModel;
@end
