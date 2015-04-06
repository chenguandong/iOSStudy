//
//  FavouriteViewControllerViewModel.h
//  iOSStudy
//
//  Created by chenguandong on 15/4/6.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@interface FavouriteViewControllerViewModel : NSObject

@property(nonatomic,strong)NSMutableArray *array;

- (NSInteger)getNumberOfRowsInSection;
/**
 *   查询收藏的数据
 *
 *  @param type 查询的类型
 *
 *  @return 收藏数据的集合
 */
-(NSArray*)getFavouriteData:(NSString*)type;
@end
