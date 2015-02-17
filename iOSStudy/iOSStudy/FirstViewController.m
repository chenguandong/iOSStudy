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
             
             if ([_tableView isHeaderRefreshing]) {
             [_tableView headerEndRefreshing];
             }

        } modelDataErrors:^{

             if ([_tableView isHeaderRefreshing]) {
             [_tableView headerEndRefreshing];
             }

        } modelDataIsNetworking:^(BOOL isNetWorking) {

             if ([_tableView isHeaderRefreshing]) {
             [_tableView headerEndRefreshing];
             }

        }];
    }];
    

    [self.tableView headerBeginRefreshing];


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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    
    ;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

    cell.textLabel.text = [_viewModel getBlogBean:indexPath].title;
    cell.detailTextLabel.text = [_viewModel getBlogBean:indexPath].subTitle;

    
    [cell.imageView setImageWithURL:[NSURL URLWithString:[_viewModel getBlogBean:indexPath].image] placeholderImage:[UIImage imageNamed:@"SVWebViewControllerActivitySafari-iPad"]];
    


    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:[_viewModel getBlogBean:indexPath].url];
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
