//
//  GuideViewController.m
//  谈资APP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>{
    UIScrollView * _scrollView;
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScroll];
    
    // Do any additional setup after loading the view.
}
-(void)createScroll{

    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*5, [UIScreen mainScreen].bounds.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;//设置横向滚动条
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;//翻页
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    for(int i=0;i<5;i++){
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
    }
    //[self.view addSubview:_scrollView];

}
#pragma mark -- 滚动结束
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  //偏移量
    CGPoint point = scrollView.contentOffset;
    //滑到最后一个视图
    if(point.x > [UIScreen mainScreen].bounds.size.width*5+200){
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"1" forKey:@"sucess"];//保存一个1 把key值设为success
        [defaults synchronize];//这句话的意思就是把数据存到硬盘上

    
        self.block();//进入首页切换跟视图
    }
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
