//
//  BaseTableViewCell.m
//  iOSStudy
//
//  Created by chenguandong on 15/4/9.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "STBaseTableViewCell.h"

@implementation STBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
   self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setImageScale{
    _imageIcon.layer.contentsScale = 30;
    _imageIcon.layer.masksToBounds = YES;
}

@end
