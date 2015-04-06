//
//  FirstViewControllerViewModel.m
//  iOSStudy
//
//  Created by chenguandong on 15/2/16.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "ThirdViewControllerViewModel.h"

@implementation ThirdViewControllerViewModel
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



-(WebBean*)getBlogBean:(NSIndexPath *)indexPath{
    
    return _array[indexPath.row];
}


-(void)getDate:(modelSuccess)modelDataSuccess modelDataErrors:(modelError)modelDataErrors modelDataIsNetworking:(modelNetWorking)modelDataIsNetWoring{
    
    
    //
    [NetWorkTools postHttp:Adress_videos success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", [operation responseString]);
        
        NSArray *dic = [JsonTools getJsonNSDictionary:[operation responseString]];
        
        //将JSON数据和Model的属性进行绑定
        
        
        NSArray *arr = [MTLJSONAdapter modelsOfClass:[VideoBean class] fromJSONArray:dic error:nil];
        
        for (VideoBean *bean in arr) {
            NSLog(@"%@",bean.webImage);
        }
        
        _array = [arr copy];
        
       
        modelDataSuccess();
    
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        modelDataErrors();
       
    } isNetworking:^(BOOL isNetwork) {
        
        
        modelDataIsNetWoring(isNetwork);
       
        
    }];
    
    
}
@end
