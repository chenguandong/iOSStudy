//
//  ThirdTableViewController.m
//  iOSStudy
//
//  Created by chenguandong on 15/2/10.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "ThirdTableViewController.h"
#import "NetWorkTools.h"
#import "Constants .h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JsonTools.h"
#import "BlogBean.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BlogDetailViewController.h"
#import <SVWebViewController.h>
#import <MJRefresh.h>
@interface ThirdTableViewController ()

@end

@implementation ThirdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    _viewModel = [[ThirdViewControllerViewModel alloc]init];
    
    
    
    [_tableView addHeaderWithCallback:^{
        [_viewModel getDate:^{
            
            [_tableView reloadData];
            
            [self stopEndRefreshing];
            
        } modelDataErrors:^{
            
            [self stopEndRefreshing];
            
        } modelDataIsNetworking:^(BOOL isNetWorking) {
            
            [self stopEndRefreshing];
            
        }];
    }];
    
    
    
    
    
    [self.tableView headerBeginRefreshing];
    
    
}

/**
 *  停止UITableView刷新
 */
-(void)stopEndRefreshing{
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
    
    static NSString *CellIdentifier = @"VideoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    ;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    cell.textLabel.text = [_viewModel getBlogBean:indexPath].title;
    cell.detailTextLabel.text = [_viewModel getBlogBean:indexPath].subTitle;
    
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:[_viewModel getBlogBean:indexPath].webImage] placeholderImage:[UIImage imageNamed:@"SVWebViewControllerActivitySafari-iPad"]];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:[_viewModel getBlogBean:indexPath].webUrl];
    [self presentViewController:webViewController animated:NO completion:NULL];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"SVWebViewController"]) {
        
        
    }
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
