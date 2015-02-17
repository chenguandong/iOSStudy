//
//  WebBean.h
//  iOSStudy
//
//  Created by chenguandong on 15/2/17.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>
@interface WebBean : MTLModel<MTLJSONSerializing>
@property(nonatomic,copy)NSString*name;
@property(nonatomic,copy)NSString*title;
@property(nonatomic,copy)NSString*subTitle;
@property(nonatomic,copy)NSString*webImage;
@property(nonatomic,copy)NSString*webUrl;
@end
