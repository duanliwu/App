//
//  RegiestViewController.h
//  谈资APP
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^loginBlock)(UITextField * ,UITextField * );


@interface RegiestViewController : UIViewController
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UIButton * button;
@property(nonatomic,strong)UITextField * field1;
@property(nonatomic,strong)UITextField * field2;
@property(nonatomic,strong)UITextField * field3;
@property(nonatomic,strong)UIButton * submitBtn;
@property(nonatomic,strong)UIButton * registBtn;


@property (nonatomic,copy) loginBlock logBlock;
@end
