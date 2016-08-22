//
//  DetailViewController.m
//  谈资APP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"
#import "DiscussViewController.h"
#import "UMSocial.h"
#import "ShouCangViewController.h"
#import "FMDatabase.h"
#import "DBManager.h"
@interface DetailViewController ()<UIWebViewDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationController.navigationBarHidden = YES;
    [self createView];
    [self createData];
    [self createTabBar];
    //[self createButton];
    // Do any additional setup after loading the view.
}
//-(void)setModel:(NewModel *)model{
//    _model=model;
//}

//创建TabBar
-(void)createTabBar{

    self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49, [UIScreen mainScreen].bounds.size.width, 49)];
    self.imageView1.userInteractionEnabled = YES;
    self.imageView1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.imageView1];
    
    //NSArray * array = @[@"评论",@"点赞",@"收藏",@"分享"];
    
    for(int i =0;i<4;i++){
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20+(50+50)*i,[UIScreen mainScreen].bounds.size.height-40, 30, 30);
        [button addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"c%d",i]] forState:UIControlStateNormal];
        button.tag = 100+i;
        [self.view addSubview:button];
    }
    
    
    
 
}
-(void)next:(UIButton *)btn{
    if(btn.tag == 102){
    
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_collect@2x"] forState:UIControlStateNormal];
    
    }
    
    
    if(btn.tag == 102){//点击收藏按钮 如果数据库里面没有这个模型 就加入数据库 
        DBManager *db = [DBManager shareManager];//单例创建一个数据库
        if(![db isExistsWithId:self.model]){//先进行判断 如果不存在 就创建 插入模型 
            [db insertModel:self.model];//如果有过就不用再添加这个数据库了
            NSLog(@"插入数据成功");//因为这个方法 插入的就是模型 所以 参数也应该是模型
            NSLog(@"zdfssd%@",self.model);
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
            [alert show];
            
            
        }else
        {
        [db deleteModelWithId:self.model];       //这一步应该是没有错误的  点击第二下取消收藏
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消收藏成功" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
            [alert show];

        }
    }
  
    if(btn.tag == 103){
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"507fcab25270157b37000010" shareText:@"" shareImage:nil shareToSnsNames:@[UMShareToQQ,UMShareToWechatTimeline,UMShareToSina,UMShareToQzone,UMShareToSms,UMShareToTwitter,UMShareToRenren,UMShareToEmail] delegate:nil];//5个分享
    }
}


-(void)createView{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    self.imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView];
    self.imageView.userInteractionEnabled = YES;
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(10, 20, 60, 40);
    [self.button setTitle:@"<返回" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}
-(void)createData{

    NSString * str = [NSString stringWithFormat:@"http://mobile.itanzi.com/Wap/WapArticle/index?itanzi_article_id=%@&pos=3&cat=nt0",self.DetailStr];
    UIWebView * Web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    Web.delegate =self;
    NSURL * url = [NSURL URLWithString:str];//先转网址
    NSURLRequest * quest = [NSURLRequest requestWithURL:url];//请求
    [Web loadRequest:quest];//加载数据
    [self.view addSubview:Web];



}

-(void)back:(UIButton *)button{
    
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
