//
//  FirstViewControllerViewModel.m
//  iOSStudy
//
//  Created by chenguandong on 15/2/16.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "ThirdViewControllerViewModel.h"

@implementation ThirdViewControllerViewModel


-(void)persistenceDataWithType:(NSString *)type{
    
    //删除已经存在的数据
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"type= %@", type];
    [CoreDataUtils deleteDateFromTableName:CD_FAVOURITE_BEAN andNSPredicate:titlePredicate];
    
    
    for (VideoBean *bean in self.array) {
        
        if ([self isExistSimpleDataWithURL:bean.webUrl]) {
            NSLog(@"已经有这条数据了");
        }else{
            NSManagedObject *favouriteBean =[NSEntityDescription insertNewObjectForEntityForName:CD_FAVOURITE_BEAN inManagedObjectContext:SharedApp.managedObjectContext];
            
            
            [favouriteBean setValue:bean.title forKey:FavouriteBean_title];
            [favouriteBean setValue:bean.subTitle forKey:FavouriteBean_subtitle];
            [favouriteBean setValue:bean.webImage forKey:FavouriteBean_image_name];
            [favouriteBean setValue:bean.webUrl forKey:FavouriteBean_url];
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

@end
