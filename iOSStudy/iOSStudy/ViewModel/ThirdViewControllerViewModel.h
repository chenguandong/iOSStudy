//
//  FirstViewControllerViewModel.h
//  iOSStudy
//
//  Created by chenguandong on 15/2/16.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkTools.h"
#import "JsonTools.h"
#import "WebBean.h"
typedef void (^modelSuccess)();
typedef void (^modelError)();
typedef void (^modelNetWorking)(BOOL isNetWorking);

@interface ThirdViewControllerViewModel : NSObject
@property(nonatomic,strong)NSArray *array;

/**
 *  获取推荐网站数据
 *
 *  @param modelDataSuccess     获取推荐网站数据成功
 *  @param modelDataErrors      获取推荐网站数据失败
 *  @param modelDataIsNetWoring 是否有网络连接
 */
-(void)getDate:(modelSuccess)modelDataSuccess modelDataErrors:(modelError)modelDataErrors modelDataIsNetworking:(modelNetWorking)modelDataIsNetWoring;

/**
 *  返回table 的行数
 *
 *  @return table行数
 */
- (NSInteger)getNumberOfRowsInSection;


/**
 *  返回单个cell的数据
 *
 *  @param indexPath cell 的indexPath
 *
 *  @return cell的数据
 */
-(WebBean*)getBlogBean:(NSIndexPath *)indexPath;
@end
