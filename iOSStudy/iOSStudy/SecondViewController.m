//
//  SecondViewController.m
//  iOSStudy
//
//  Created by chenguandong on 15/1/29.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "SecondViewController.h"
#import "NetWorkTools.h"
#import "Constants .h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JsonTools.h"
#import "BlogBean.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BlogDetailViewController.h"
#import <SVWebViewController.h>
#import <MJRefresh.h>
#import <SVModalWebViewController.h>
#import "EntityConstants.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self initViewData];

}



-(void)initViewData{
    
    _favouriteType = TYPE_BLOG_FAVOURITE_TYPE;
    
    _viewModel = [[SecondViewControllerViewModel alloc]init];
    
    [self.tableView addHeaderWithCallback:^{
        
        
        [_viewModel getDate:^{
            [_tableView reloadData];
            
            [self stopTableRefreshing];
            
        } modelDataReload:^{
            [_tableView reloadData];
        } modelDataErrors:^{
            [self stopTableRefreshing];
        } modelDataIsNetworking:^(BOOL isNetWorking) {
            [self stopTableRefreshing];
        } httpAdress:Adress_webs dataType:TYPE_WEB_SIMPLE_TYPE jsonClass:[WebBean class]];
        
        
        
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
    
    static NSString *CellIdentifier = @"WebCell";
    SWTableViewCell *cell = (SWTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    cell.delegate = self;
    
    
    cell.textLabel.text = [[_viewModel getBlogBean:indexPath]valueForKey:FavouriteBean_title];
    cell.detailTextLabel.text = [[_viewModel getBlogBean:indexPath] valueForKey:FavouriteBean_subtitle];
    
    
    
    cell.rightUtilityButtons =[_viewModel setRightSWCellButtons:[[_viewModel getBlogBean:indexPath] valueForKey:FavouriteBean_url] withType:TYPE_BLOG_FAVOURITE_TYPE];
    
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:[[_viewModel getBlogBean:indexPath] valueForKey:FavouriteBean_image_name]] placeholderImage:[UIImage imageNamed:@"SVWebViewControllerActivitySafari-iPad.png"]];
    

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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
