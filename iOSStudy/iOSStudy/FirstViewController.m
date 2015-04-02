//
//  FirstViewController.m
//  iOSStudy
//
//  Created by chenguandong on 15/1/29.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "FirstViewController.h"
#import "NetWorkTools.h"
#import "Constants .h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JsonTools.h"
#import "BlogBean.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BlogDetailViewController.h"
#import <SVWebViewController.h>
#import <MJRefresh.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    _tableView.delegate = self;
    _tableView.dataSource = self;
    

    _viewModel = [[FirstViewControllerViewModel alloc]init];
    
    
    
    [self.tableView addHeaderWithCallback:^{
        [_viewModel getDate:^{

             [_tableView reloadData];
             
            [self stopTableRefreshing];

        } modelDataErrors:^{

            [self stopTableRefreshing];

        } modelDataIsNetworking:^(BOOL isNetWorking) {

            [self stopTableRefreshing];

        }];
    }];
    

    [self.tableView headerBeginRefreshing];


}



/**
 *  停止UITableView刷新
 */
-(void)stopTableRefreshing{
    if ([_tableView isHeaderRefreshing]) {
        [_tableView headerEndRefreshing];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_viewModel getNumberOfRowsInSection];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"Cell";
    SWTableViewCell *cell = (SWTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
       
    }
    
    cell.rightUtilityButtons =[self rightButtons];
    cell.delegate = self;


    cell.textLabel.text = [_viewModel getBlogBean:indexPath].title;
    cell.detailTextLabel.text = [_viewModel getBlogBean:indexPath].subTitle;

    
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:[_viewModel getBlogBean:indexPath].image] placeholderImage:[UIImage imageNamed:@"SVWebViewControllerActivitySafari-iPad.png"]];
    

    return cell;
}


#pragma mark --设置又滑菜单
- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"收藏"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"不喜欢"];
    
    return rightUtilityButtons;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:[_viewModel getBlogBean:indexPath].url];
    [self presentViewController:webViewController animated:NO completion:NULL];
 
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"SVWebViewController"]) {
      
        
    }
}


#pragma mark-- SWTableViewCell delagate

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{

    return  YES;
}
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state{
    
    return YES;

}

- (void)swipeableTableViewCellDidEndScrolling:(SWTableViewCell *)cell{
    
    //根据侧滑按钮是否显示设置箭头标志
    if (cell.isUtilityButtonsHidden) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            NSLog(@"不喜欢");
            {
                NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
                [_viewModel saveFavourite:indexPath];

            }
            break;
        case 1:
            NSLog(@"收藏");

            break;
            
        default:
            break;
    }
    [cell hideUtilityButtonsAnimated:YES];
    
}




-(void)dealloc{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _viewModel = nil;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
