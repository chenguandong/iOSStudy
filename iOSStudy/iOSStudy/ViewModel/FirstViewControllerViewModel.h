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
#import "BlogBean.h"
typedef void (^modelSuccess)();
typedef void (^modelError)();
typedef void (^modelNetWorking)(BOOL isNetWorking);

@interface FirstViewControllerViewModel : NSObject
@property(nonatomic,strong)NSArray *array;

/**
 *  获取博客数据
 *
 *  @param modelDataSuccess     获取博客数据成功
 *  @param modelDataErrors      获取博客数据失败
 *  @param modelDataIsNetWoring 是否有网络
 */
-(void)getDate:(modelSuccess)modelDataSuccess modelDataErrors:(modelError)modelDataErrors modelDataIsNetworking:(modelNetWorking)modelDataIsNetWoring;

/**
 *  获取table的行数
 *
 *  @return table的行数
 */
- (NSInteger)getNumberOfRowsInSection;

/**
 *  获取cell的数据
 *
 *  @param indexPath indexPath
 *
 *  @return cell的数据
 */
-(BlogBean*)getBlogBean:(NSIndexPath *)indexPath;
@end
