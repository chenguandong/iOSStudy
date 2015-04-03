//
//  BlogJsonBean.h
//  iOSStudy
//
//  Created by chenguandong on 15/4/2.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>
@interface BlogJsonBean : MTLModel<MTLJSONSerializing>
@property(nonatomic,copy)NSString *version;
@property(nonatomic,strong)NSArray *bloglists;
@end
