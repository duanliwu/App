//
//  DiscussViewController.m
//  谈资APP
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DiscussViewController.h"

@interface DiscussViewController ()

@end

@implementation DiscussViewController
//这个页面是地图的功能 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    
    // Do any additional setup after loading the view.
}
-(void)createUI{

    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    img.backgroundColor = [UIColor redColor];
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 20, 40, 40);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [img addSubview:btn];


}
-(void)back:(UIButton *)btn{

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
