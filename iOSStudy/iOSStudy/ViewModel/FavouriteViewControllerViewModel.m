//
//  FavouriteViewControllerViewModel.m
//  iOSStudy
//
//  Created by chenguandong on 15/4/6.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "FavouriteViewControllerViewModel.h"
#import "CoreDataUtils.h"
#import "Constants .h"
@implementation FavouriteViewControllerViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array  = [NSMutableArray array];
    }
    return self;
}
-(NSManagedObject*)getFavouriteObjtBean:(NSIndexPath *)indexPath{
    return _array[indexPath.row];
}



-(NSArray*)getFavouriteData:(NSString*)type{
    
    
    
     NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"type= %@", type];
    NSArray *array = [CoreDataUtils queryDataFromTableName:CD_FAVOURITE_BEAN andNSPredicate:typePredicate];
    _array = [array copy];
    
    NSLog(@"cout=%ld",_array.count);
    
    return _array;
}

- (NSInteger)getNumberOfRowsInSection{
    
    return _array.count;
}





@end
