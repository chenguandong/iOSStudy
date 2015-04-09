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


/**
 *  网络请求开始
 */
typedef void (^modelPersistentReload)();

/**
 *  网络请求成功回调
 */
typedef void (^modelSuccess)();
/**
 *  网络请求失败回调
 */
typedef void (^modelError)();

/**
 *  网络是否链接回调
 *
 *  @param isNetWorking YES 有网络 NO 没有网络
 */
typedef void (^modelNetWorking)(BOOL isNetWorking);

@interface BlogViewControllerViewModel : NSObject
@property(nonatomic,strong)NSArray *array;


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
-(NSManagedObject*)getBlogBean:(NSIndexPath *)indexPath;



/**
 *  添加收藏到数据库
 *
 *  @param indexPath indexPath
 */
-(void)saveFavourite:(NSIndexPath*)indexPath favouriteType:(NSString*)type;




/**
 *  请求网络数据
 *
 *  @param modelDataSuccess     请求成功
 *  @param modelDataStart       请求开始
 *  @param modelDataErrors      请求失败
 *  @param modelDataIsNetWoring 网络状态
 */
-(void)getDate:(modelSuccess)modelDataSuccess modelDataReload:(modelPersistentReload)modelDataReload modelDataErrors:(modelError)modelDataErrors modelDataIsNetworking:(modelNetWorking)modelDataIsNetWoring httpAdress:(NSString*)httpAdress dataType:(NSString*)dataType jsonClass:(Class)myClass;


/**
 *  设置SWTableViewCell 滑动文字
 *
 *  @param url  url地址
 *  @param type 1 博客 2 网址 3 视频
 *
 *  @return 要显示的Button集合
 */
- (NSArray *)setRightSWCellButtons:(NSString*)url withType:(NSString*)type;

#pragma mark -- 持久化所有数据
-(void)persistenceDataWithType:(NSString*)type;

/**
 *  判断收藏的URL地址是否存在
 *
 *  @param url URL地址
 *
 *  @return YES 存在   NO 不存在
 */
-(BOOL)isExistSimpleDataWithURL:(NSString*)url;
@end
