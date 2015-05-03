//
//  BaseTableViewCell.h
//  iOSStudy
//
//  Created by chenguandong on 15/4/9.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWTableViewCell.h>
@interface STBaseTableViewCell :SWTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@end
