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
#import "EntityConstants.h"
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
-(void)getDate:(modelSuccess)modelDataSuccess modelDataReload:(modelPersistentReload)modelDataReload modelDataErrors:(modelError)modelDataErrors modelDataIsNetworking:(modelNetWorking)modelDataIsNetWoring httpAdress:(NSString*)httpAdress dataType:(NSString*)dataType jsonClass:(Class)myClass{
    
    
    _array = [[self getPersistenceDataWithType:dataType]copy];
   

    modelDataReload();
    
    __block NSString *versionStr;
    
    if ([HttpVersionTools checkHttpVersion:httpAdress nowVersion:[HttpVersionTools getNowHttpVersion:httpAdress]]) {
        
        //
 
        [NetWorkTools postHttp:httpAdress success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"JSON: %@", [operation responseString]);
            
            NSDictionary *dic = [JsonTools getJsonNSDictionary:[operation responseString]];
            
            //NSLog(@"jsonVersion=%@",dic[@"version"]);
            
            
            versionStr =dic[@"version"];
            
            //将JSON数据和Model的属性进行绑定
            
            // NSLog(@"%@arr=",dic[@"bloglists"]);
            
            NSArray *arr = [MTLJSONAdapter modelsOfClass:myClass fromJSONArray:dic[@"bloglists"] error:nil];
            
            
            
            _array = [arr copy];
            
 
            
            //持久化数据
            [self persistenceDataWithType:dataType];
            
            //当前最新版本号存入数据库
            
            [HttpVersionTools saveNowHttpVersion:httpAdress version:versionStr];
            
             _array = [[self getPersistenceDataWithType:dataType]copy];
            
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

     
    return fetchedObjects;

}

#pragma mark -- 持久化所有数据
-(void)persistenceDataWithType:(NSString*)type{
    
    //删除已经存在的数据
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"type= %@", type];
    [CoreDataUtils deleteDateFromTableName:CD_FAVOURITE_BEAN andNSPredicate:titlePredicate];
    
    
    for (BlogBean *bean in _array) {
        
        if ([self isExistSimpleDataWithURL:bean.url]) {
            NSLog(@"已经有这条数据了");
        }else{
            NSManagedObject *favouriteBean =[NSEntityDescription insertNewObjectForEntityForName:CD_FAVOURITE_BEAN inManagedObjectContext:SharedApp.managedObjectContext];
            
            
            [favouriteBean setValue:bean.title forKey:FavouriteBean_title];
            [favouriteBean setValue:bean.subTitle forKey:FavouriteBean_subtitle];
            [favouriteBean setValue:bean.image forKey:FavouriteBean_image_name];
            [favouriteBean setValue:bean.url forKey:FavouriteBean_url];
            [favouriteBean setValue:type forKey:FavouriteBean_type];
   
            
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


-(void)saveFavourite:(NSIndexPath*)indexPath favouriteType:(NSString*)type{
    
    NSManagedObject *loveBean = _array[indexPath.row];
    
   
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"url= %@ AND type=%@", [loveBean valueForKey:FavouriteBean_url],type];
    NSArray*favouriteList = [CoreDataUtils queryDataFromTableName:CD_FAVOURITE_BEAN andNSPredicate:urlPredicate];
    if (favouriteList.count!=0) {
        NSLog(@"已经有这条数据了 ");//更新收藏的状态
        
        
        [SharedApp.managedObjectContext deleteObject:favouriteList[0]];
        
        
        NSError *error = nil;
        [SharedApp.managedObjectContext save:&error];
        if (error) {
            
            NSLog(@"删除收藏失败%@",[error userInfo]);
        }else{
            NSLog(@"删除收藏成功");
        }
    }else{
        
        //添加收藏
        NSManagedObject *favouriteBean  = [NSEntityDescription insertNewObjectForEntityForName:CD_FAVOURITE_BEAN inManagedObjectContext:SharedApp.managedObjectContext];
        
        [favouriteBean setValue:[loveBean valueForKey:FavouriteBean_title] forKey:FavouriteBean_title];
        [favouriteBean setValue:[loveBean valueForKey:FavouriteBean_subtitle] forKey:FavouriteBean_subtitle];
        [favouriteBean setValue:[loveBean valueForKey:FavouriteBean_image_name] forKey:FavouriteBean_image_name];
        [favouriteBean setValue:[loveBean valueForKey:FavouriteBean_url] forKey:FavouriteBean_url];
        [favouriteBean setValue:type forKey:FavouriteBean_type];
    }
    
    NSError *error;
    BOOL isSaveSuccess =[SharedApp.managedObjectContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else {
        NSLog(@"Save successful favourite!");
    }

    
  
    
    
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
    
    return rightUtilityButtons;
    
    
}




@end
