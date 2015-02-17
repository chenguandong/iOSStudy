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

-(void)getDate:(modelSuccess)modelDataSuccess modelDataErrors:(modelError)modelDataErrors modelDataIsNetworking:(modelNetWorking)modelDataIsNetWoring;

- (NSInteger)getNumberOfRowsInSection;

-(BlogBean*)getBlogBean:(NSIndexPath *)indexPath;
@end
