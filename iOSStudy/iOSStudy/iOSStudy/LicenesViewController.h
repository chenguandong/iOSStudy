//
//  LicenesViewController.h
//  iOSStudy
//
//  Created by chenguandong on 15/4/9.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface LicenesViewController :BaseViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,copy)NSString *htmlName;
@end
