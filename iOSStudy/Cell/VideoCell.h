//
//  VideoCell.h
//  iOSStudy
//
//  Created by chenguandong on 15/2/24.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <SWTableViewCell.h>
@interface VideoCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *videoSubTitle;

@end
