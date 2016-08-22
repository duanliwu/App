//
//  GuideViewController.h
//  谈资APP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HuanYing)(void);
@interface GuideViewController : UIViewController
@property(nonatomic,copy)HuanYing  block;
@end
