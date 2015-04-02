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



-(BlogBean*)getBlogBean:(NSIndexPath *)indexPath{
    
    return _array[indexPath.row];
}


-(void)getDate:(modelSuccess)modelDataSuccess modelDataErrors:(modelError)modelDataErrors modelDataIsNetworking:(modelNetWorking)modelDataIsNetWoring{
    
    
    _array = [[self getPersistenceData]copy];
    
    modelDataSuccess();
    
    
    
    
    //
    [NetWorkTools postHttp:Address_blogs success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", [operation responseString]);
        
        NSArray *dic = [JsonTools getJsonNSDictionary:[operation responseString]];
        
        //将JSON数据和Model的属性进行绑定
        
        NSArray *arr = [MTLJSONAdapter modelsOfClass:[BlogBean class] fromJSONArray:dic error:nil];
        
        for (BlogBean *bean in arr) {
            NSLog(@"%@",bean.image);
        }
        
        _array = [arr copy];
        
       
        modelDataSuccess();
        
        [self persistenceData];
    
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        modelDataErrors();
       
    } isNetworking:^(BOOL isNetwork) {
        
        
        modelDataIsNetWoring(isNetwork);
       
        
    }];
    
    
}

#pragma mark -- 得到持久化的数据
-(NSArray*)getPersistenceData{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:CD_FAVOURITE_BEAN inManagedObjectContext:SharedApp.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [SharedApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *blogArr = [NSMutableArray arrayWithCapacity:10];
    
    
    for (NSManagedObject *info in fetchedObjects) {

        BlogBean *blogBean = [[BlogBean alloc]init];
        blogBean.title = [info valueForKey:@"title"];
        blogBean.subTitle=[info valueForKey:@"subtitle"];
        blogBean.image = [info valueForKey:@"image_name"];
        blogBean.url = [info valueForKey:@"url"];
        [blogArr addObject:blogBean];
        
    }

    return blogArr;

}

//持久化所有数据
-(void)persistenceData{
    
    for (BlogBean *bean in _array) {
        
        if ([self isExistURL:bean.url]) {
            NSLog(@"已经有这条数据了");
        }else{
            FavouriteBean *favouriteBean = (FavouriteBean*)[NSEntityDescription insertNewObjectForEntityForName:CD_FAVOURITE_BEAN inManagedObjectContext:SharedApp.managedObjectContext];
            
            
            favouriteBean.title = bean.title;
            favouriteBean.subtitle = bean.subTitle;
            favouriteBean.image_name = bean.image;
            favouriteBean.url= bean.url;
            favouriteBean.type =@"0";
      
            
            NSError *error;
            BOOL isSaveSuccess =[SharedApp.managedObjectContext save:&error];
            if (!isSaveSuccess) {
                NSLog(@"Error: %@,%@",error,[error userInfo]);
            }else {
                NSLog(@"Save successful favourite!");
            }
            
            
        }
        
    }

}


-(void)saveFavourite:(NSIndexPath*)indexPath{
    
    BlogBean *loveBean = _array[indexPath.row];
    
    
    if ([self isExistURL:loveBean.url]) {
        NSLog(@"已经有这条数据了");
    }else{
        FavouriteBean *favouriteBean = (FavouriteBean*)[NSEntityDescription insertNewObjectForEntityForName:CD_FAVOURITE_BEAN inManagedObjectContext:SharedApp.managedObjectContext];
        
        
        favouriteBean.title = loveBean.title;
        favouriteBean.subtitle = loveBean.subTitle;
        favouriteBean.image_name = loveBean.image;
        favouriteBean.url= loveBean.url;
        favouriteBean.type =@"1";
        
        
        
        NSError *error;
        BOOL isSaveSuccess =[SharedApp.managedObjectContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"Error: %@,%@",error,[error userInfo]);
        }else {
            NSLog(@"Save successful favourite!");
        }
        

    }
    
    
}

//检查这个URL在数据库是否存在
-(BOOL)isExistURL:(NSString*)url{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:CD_FAVOURITE_BEAN inManagedObjectContext:SharedApp.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [SharedApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    

    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"Name: %@", [info valueForKey:@"title"]);
        /*
        NSManagedObject *details = [info valueForKey:@"details"];
        NSLog(@"Zip: %@", [details valueForKey:@"zip"]);
         */
    }

    
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"url = %@", url];
    

    NSArray *resultArr = [fetchedObjects filteredArrayUsingPredicate:titlePredicate];
    if (resultArr.count!=0) {
        NSLog(@"111%lu",resultArr.count);
        return YES;
    }else{
        NSLog(@"222%lu",resultArr.count);
        return NO;
    }
    
    
}


@end
