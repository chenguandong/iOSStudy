//
//  BlogBean.h
//  iOSStudy
//
//  Created by chenguandong on 15/2/5.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>
@interface BlogBean : MTLModel<MTLJSONSerializing>
@property(nonatomic,copy)NSString*name;
@property(nonatomic,copy)NSString*title;
@property(nonatomic,copy)NSString*subTitle;
@property(nonatomic,copy)NSString*image;
@property(nonatomic,copy)NSString*url;
@property(nonatomic,copy)NSString*rssUrl;
@property(nonatomic,copy)NSString*date;
@end
