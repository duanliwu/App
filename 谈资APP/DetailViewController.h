//
//  DetailViewController.h
//  谈资APP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALLModel;
@interface DetailViewController : UIViewController

@property(nonatomic,copy)NSString * DetailStr;
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UIButton * button;
@property(nonatomic,strong)UIImageView * imageView1;

@property (nonatomic,strong)ALLModel *model;   //这个model里面保存的是 点击cell进去的模型 
@end
