//
//  VideoBean.h
//  iOSStudy
//
//  Created by chenguandong on 15/2/22.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "WebBean.h"

@interface VideoBean : MTLModel<MTLJSONSerializing>
/**
 *  zh 中文  us 英文
 */
@property(nonatomic,copy)NSString *videoLanguageType;



/**
 *  网站标题
 */
@property(nonatomic,copy)NSString*title;
/**
 *  网站描述
 */
@property(nonatomic,copy)NSString*subTitle;
/**
 *  网站图片
 */
@property(nonatomic,copy)NSString*webImage;
/**
 *  网站地址
 */
@property(nonatomic,copy)NSString*webUrl;

@end
