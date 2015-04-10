//
//  LicenesViewController.m
//  iOSStudy
//
//  Created by chenguandong on 15/4/9.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "LicenesViewController.h"

@implementation LicenesViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:_htmlName ofType:nil]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}



@end
