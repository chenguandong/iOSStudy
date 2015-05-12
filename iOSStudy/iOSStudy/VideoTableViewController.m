//
//  ThirdTableViewController.m
//  iOSStudy
//
//  Created by chenguandong on 15/2/10.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "VideoTableViewController.h"
#import "NetWorkTools.h"
#import "Constants .h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JsonTools.h"
#import "BlogBean.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BlogDetailViewController.h"
#import <SVWebViewController.h>
#import <MJRefresh.h>
#import "STBaseTableViewCell.h"
#import "UIImage+Resize.h"
#import <SVModalWebViewController.h>
#import "STBaseTableViewCell.h"
@interface VideoTableViewController ()

@end

@implementation VideoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self initViewData];
    
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationReloadData:) name:notifacationVideoReload object:nil];
}

-(void)notificationReloadData:(NSNotification*)notifacation{
    
    
    [_tableView reloadData];
}

-(void)initViewData{
    
    _favouriteType = TYPE_VIDEO_FAVOURITE_TYPE;
    
    _viewModel = [[VideoViewControllerViewModel alloc]init];
    
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [_viewModel getDate:^{
            [_tableView reloadData];
            
            [self stopTableRefreshing];
            
        } modelDataReload:^{
            [_tableView reloadData];
        } modelDataErrors:^{
            [self stopTableRefreshing];
        } modelDataIsNetworking:^(BOOL isNetWorking) {
            [self stopTableRefreshing];
        } httpAdress:Adress_videos dataType:TYPE_VIDEO_SIMPLE_TYPE jsonClass:[VideoBean class]];
    }];
    
    // 隐藏时间
    self.tableView.header.updatedTimeHidden = YES;
    // 隐藏状态
    self.tableView.header.stateHidden = YES;
    
    [self.tableView.header beginRefreshing];
    
    _tableView.rowHeight = 60;
    
     [self.tableView registerNib:[UINib nibWithNibName:@"STBaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
}





/**
 *  停止UITableView刷新
 */
-(void)stopTableRefreshing{
    if ([_tableView.header isRefreshing]) {
        [_tableView.header endRefreshing];
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
    
    
    static NSString *cellIdentifier = @"VideoCell";
    
    STBaseTableViewCell *cell = (STBaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                                           forIndexPath:indexPath];

    
    
    cell.delegate = self;

    
    
    cell.title.text = [[_viewModel getBlogBean:indexPath]valueForKey:FavouriteBean_title];
    cell.subtitle.text = [[_viewModel getBlogBean:indexPath] valueForKey:FavouriteBean_subtitle];
    


    NSLog(@"==%@",  [[_viewModel getBlogBean:indexPath] valueForKey:FavouriteBean_subtitle]);
    
    
    cell.rightUtilityButtons =[_viewModel setRightSWCellButtons:[[_viewModel getBlogBean:indexPath] valueForKey:FavouriteBean_url] withType:_favouriteType];
    
    
    [cell.imageIcon setImageWithURL:[NSURL URLWithString:[[_viewModel getBlogBean:indexPath] valueForKey:FavouriteBean_image_name]] placeholderImage:[UIImage imageNamed:@"SVWebViewControllerActivitySafari-iPad.png"]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:[[_viewModel getBlogBean:indexPath] valueForKey:FavouriteBean_url]];
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
    
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    
    [_viewModel saveFavourite:indexPath favouriteType:_favouriteType];
    
    
    [cell hideUtilityButtonsAnimated:YES];
    
    [_tableView reloadData];
    
    
    
}





-(void)dealloc{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _viewModel = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:notifacationVideoReload object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
