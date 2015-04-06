//
//  FavouriteTableViewController.m
//  iOSStudy
//
//  Created by chenguandong on 15/4/6.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "FavouriteTableViewController.h"
#import "Constants .h"
#import "EntityConstants.h"

typedef NS_ENUM(NSInteger, segmentedSelect) {
    BlogSelect = 0,
    WebSelect  =1,
    VideoSelect = 2
};

@implementation FavouriteTableViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [_viewModel getFavouriteData:TYPE_BLOG_FAVOURITE_TYPE];
    [self.tableView reloadData];
}
- (IBAction)changeFavouriteType:(id)sender {
    
    NSString *favouriteType;
    
    UISegmentedControl *seColl = (UISegmentedControl*)sender;
    switch (seColl.selectedSegmentIndex) {
        case BlogSelect:

            favouriteType =TYPE_BLOG_FAVOURITE_TYPE;
            
            break;
        case WebSelect:
            
            favouriteType =TYPE_WEB_FAVOURITE_TYPE;
            break;
        case VideoSelect:
            favouriteType =TYPE_VIDEO_FAVOURITE_TYPE;
            
            break;
            
        default:
            break;
    }
    
    
    NSLog(@"%@",favouriteType);
    
    [_viewModel getFavouriteData:favouriteType];
    
    [self.tableView reloadData];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];

    _viewModel  = [[FavouriteViewControllerViewModel alloc]init];
    
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_viewModel getNumberOfRowsInSection];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"FCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    NSManagedObject *f_objt = _viewModel.array[indexPath.row];
    
    cell.textLabel.text = [f_objt valueForKey:FavouriteBean_title];
    
    
    return cell;

}


@end
