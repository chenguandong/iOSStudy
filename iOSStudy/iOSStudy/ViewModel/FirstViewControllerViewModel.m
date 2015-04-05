//
//  FirstViewControllerViewModel.m
//  iOSStudy
//
//  Created by chenguandong on 15/2/16.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "FirstViewControllerViewModel.h"
#import "FavouriteBean.h"
#import "Constants .h"
#import "BlogJsonBean.h"
#import "HttpVersionTools.h"
#import "CoreDataUtils.h"
#import <SWTableViewCell.h>
@implementation FirstViewControllerViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
        
        
    }
    return self;
}

- (NSInteger)getNumberOfRowsInSection{
    
    return _array.count;
}



-(NSManagedObject*)getBlogBean:(NSIndexPath *)indexPath{
    
    return _array[indexPath.row];
}



/**
 *  请求网络数据
 *
 *  @param modelDataSuccess     请求成功
 *  @param modelDataStart       请求开始
 *  @param modelDataErrors      请求失败
 *  @param modelDataIsNetWoring 网络状态
 */
-(void)getDate:(modelSuccess)modelDataSuccess modelDataReload:(modelPersistentReload)modelDataReload modelDataErrors:(modelError)modelDataErrors modelDataIsNetworking:(modelNetWorking)modelDataIsNetWoring{
    
    
    _array = [[self getPersistenceDataWithType:TYPE_BLOG_SIMPLE_TYPE]copy];
   

    modelDataReload();
    
    __block NSString *versionStr;
    
    if ([HttpVersionTools checkHttpVersion:Address_blogs nowVersion:[HttpVersionTools getNowHttpVersion:Address_blogs]]) {
        
        //
 
        [NetWorkTools postHttp:Address_blogs success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"JSON: %@", [operation responseString]);
            
            NSDictionary *dic = [JsonTools getJsonNSDictionary:[operation responseString]];
            
            //NSLog(@"jsonVersion=%@",dic[@"version"]);
            
            
            versionStr =dic[@"version"];
            
            //将JSON数据和Model的属性进行绑定
            
            // NSLog(@"%@arr=",dic[@"bloglists"]);
            
            NSArray *arr = [MTLJSONAdapter modelsOfClass:[BlogBean class] fromJSONArray:dic[@"bloglists"] error:nil];
            
            
            
            _array = [arr copy];
            
 
            
            //持久化数据
            [self persistenceData];
            
            //当前最新版本号存入数据库
            
            [HttpVersionTools saveNowHttpVersion:Address_blogs version:versionStr];
            
             _array = [[self getPersistenceDataWithType:TYPE_BLOG_SIMPLE_TYPE]copy];
            
            modelDataSuccess();
            
            
            
        } error:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
            modelDataErrors();
            
        } isNetworking:^(BOOL isNetwork) {
            
            
            modelDataIsNetWoring(isNetwork);
            
            
        }];
    }else{
        //直接显示持久化数据 数据显示完毕
        modelDataSuccess();
        
        NSLog(@"cout====%ld",_array.count);
    }
    
    
    
   
    
}


-(void)getDate:(modelSuccess)modelDataSuccess modelDataErrors:(modelError)modelDataErrors modelDataIsNetworking:(modelNetWorking)modelDataIsNetWoring{
    
    
    _array = [[self getPersistenceDataWithType:TYPE_BLOG_SIMPLE_TYPE]copy];
     modelDataSuccess();
   
    
    __block NSString *versionStr;
    
    if ([HttpVersionTools checkHttpVersion:Address_blogs nowVersion:[HttpVersionTools getNowHttpVersion:Address_blogs]]) {
        
        //
        [NetWorkTools postHttp:Address_blogs success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"JSON: %@", [operation responseString]);
            
            NSDictionary *dic = [JsonTools getJsonNSDictionary:[operation responseString]];
            
            //NSLog(@"jsonVersion=%@",dic[@"version"]);
            
            
            versionStr =dic[@"version"];
            
            //将JSON数据和Model的属性进行绑定
            
            // NSLog(@"%@arr=",dic[@"bloglists"]);
            
            NSArray *arr = [MTLJSONAdapter modelsOfClass:[BlogBean class] fromJSONArray:dic[@"bloglists"] error:nil];
            
       
            
            _array = [arr copy];
            
            
            modelDataSuccess();
            
            //持久化数据
            [self persistenceData];
            
            //当前最新版本号存入数据库
            
            [HttpVersionTools saveNowHttpVersion:Address_blogs version:versionStr];
            
            
        } error:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
            modelDataErrors();
            
        } isNetworking:^(BOOL isNetwork) {
            
            
            modelDataIsNetWoring(isNetwork);
            
            
        }];
    }else{
        //直接显示持久化数据 数据显示完毕
         modelDataSuccess();
        
        NSLog(@"cout====%ld",_array.count);
    }
    

    
    
}

#pragma mark -- 得到持久化的数据
-(NSArray*)getPersistenceDataWithType:(NSString*)type{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:CD_FAVOURITE_BEAN inManagedObjectContext:SharedApp.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //查询条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = %@",type];
    
    fetchRequest.predicate = predicate;
    
    NSArray *fetchedObjects = [SharedApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    /*
    
    NSMutableArray *blogArr = [NSMutableArray arrayWithCapacity:10];
    

        for (NSManagedObject *info in fetchedObjects) {
            
           
                BlogBean *blogBean = [[BlogBean alloc]init];
                blogBean.title = [info valueForKey:@"title"];
                blogBean.subTitle=[info valueForKey:@"subtitle"];
                blogBean.image = [info valueForKey:@"image_name"];
                blogBean.url = [info valueForKey:@"url"];
                NSLog(@"image=%@",blogBean.image);
                [blogArr addObject:blogBean];


        }

    
     */
     
    return fetchedObjects;

}

#pragma mark -- 持久化所有数据
-(void)persistenceData{
    
    //删除已经存在的数据
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"type= %@", @"11"];
    [CoreDataUtils deleteDateFromTableName:CD_FAVOURITE_BEAN andNSPredicate:titlePredicate];
    
    
    for (BlogBean *bean in _array) {
        
        if ([self isExistSimpleDataWithURL:bean.url]) {
            NSLog(@"已经有这条数据了");
        }else{
            FavouriteBean *favouriteBean = (FavouriteBean*)[NSEntityDescription insertNewObjectForEntityForName:CD_FAVOURITE_BEAN inManagedObjectContext:SharedApp.managedObjectContext];
            
            
            favouriteBean.title = bean.title;
            favouriteBean.subtitle = bean.subTitle;
            favouriteBean.image_name = bean.image;
            favouriteBean.url= bean.url;
            favouriteBean.type =TYPE_BLOG_SIMPLE_TYPE;
      
            
           
            
            
        }
        
    }
    
    NSError *error;
    BOOL isSaveSuccess =[SharedApp.managedObjectContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else {
        NSLog(@"Save successful favourite!");
    }

}


-(void)saveFavourite:(NSIndexPath*)indexPath{
    
    BlogBean *loveBean = _array[indexPath.row];
    
    
    if ([self isEXistFavouriteDataWithURL:loveBean.url andUrlType:TYPE_BLOG_FAVOURITE_TYPE]) {
        NSLog(@"已经有这条数据了 ");//更新收藏的状态
        
        
        
        
    }else{
        FavouriteBean *favouriteBean = (FavouriteBean*)[NSEntityDescription insertNewObjectForEntityForName:CD_FAVOURITE_BEAN inManagedObjectContext:SharedApp.managedObjectContext];
        
        
        favouriteBean.title = loveBean.title;
        favouriteBean.subtitle = loveBean.subTitle;
        favouriteBean.image_name = loveBean.image;
        favouriteBean.url= loveBean.url;
        favouriteBean.type =TYPE_BLOG_FAVOURITE_TYPE;
        
        
        
        NSError *error;
        BOOL isSaveSuccess =[SharedApp.managedObjectContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"Error: %@,%@",error,[error userInfo]);
        }else {
            NSLog(@"Save successful favourite!");
        }
        

    }
    
    
}


/**
 *  判断收藏的条目是否存在
 *
 *  @param url  url地址
 *  @param type url 类型
 *
 *  @return YES 存在 NO 不存在
 */
-(BOOL)isEXistFavouriteDataWithURL:(NSString*)url andUrlType:(NSString*)type{

    NSPredicate *urlAndurlTypePredicate = [NSPredicate predicateWithFormat:@"url = %@ AND type=%@",url,TYPE_BLOG_FAVOURITE_TYPE];
    
    return [CoreDataUtils dataisExistTableName:CD_FAVOURITE_BEAN withPredicate:urlAndurlTypePredicate];
}

/**
 *  判断收藏的URL地址是否存在
 *
 *  @param url URL地址
 *
 *  @return YES 存在   NO 不存在
 */
-(BOOL)isExistSimpleDataWithURL:(NSString*)url{
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"%@ = %@",@"url", url];
    
    return [CoreDataUtils dataisExistTableName:CD_FAVOURITE_BEAN withPredicate:urlPredicate];
}


/**
 *  判断URL 是否收藏过
 *
 *  @param url  url 地址
 *  @param type 收藏类型 1 博客 2 网址 3 视频
 *
 *  @return YES 收藏过了  NO 没有收藏过
 */
-(BOOL)queryisFavourite:(NSString*)url withType:(NSString*)type{
    //判断当前条目是否收藏 显示收藏不收藏
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"url= %@ AND type=%@", url,type];
    
    NSArray *queryList = [CoreDataUtils queryDataFromTableName:CD_FAVOURITE_BEAN andNSPredicate:titlePredicate];
    
    if (queryList.count!=0) {
        NSLog(@"cout=%ld",queryList.count);
        return YES;
    }else{
    
        return  NO;
    }
}


/**
 *  设置SWTableViewCell 滑动文字
 *
 *  @param url  url地址
 *  @param type 1 博客 2 网址 3 视频
 *
 *  @return 要显示的Button集合
 */
- (NSArray *)setRightSWCellButtons:(NSString*)url withType:(NSString*)type
{
    
    
    NSString *showText ;
    
    if ([self queryisFavourite:url withType:type]) {
        showText = textNameUnFavourite;
    }else{
        showText = textNameFavourite;
    }
    
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
     
                                                title:showText];
    
    
    /*
     [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]                                     title:@"不喜欢"];
     */
    return rightUtilityButtons;
    
    
}




@end
