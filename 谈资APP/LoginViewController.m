//
//  LoginViewController.m
//  谈资APP
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LoginViewController.h"
#import "RegiestViewController.h"
#import "AFNetworking.h"
#import "UMSocial.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    // Do any additional setup after loading the view.
}
-(void)createView{
    self.imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    self.imageView.backgroundColor = [UIColor colorWithRed:0.878  green:0.431  blue:0.275 alpha:1];
    [self.view addSubview:self.imageView];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(10, 20, 40, 40);
    [self.button setTitle:@"返回" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    
    self.field5 = [[UITextField alloc]initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 40)];
    self.field5.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.field5];
    
    self.field6 = [[UITextField alloc]initWithFrame:CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, 40)];
    self.field6.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.field6];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(50, 260, 100, 40);
    //self.btn.backgroundColor = [UIColor redColor];
    [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn setTitle:@"登录" forState:UIControlStateNormal];
    [self.btn addTarget: self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
    
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn1.frame = CGRectMake(160, 260, 40, 40);
    //self.btn.backgroundColor = [UIColor redColor];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[self.btn1 setTitle:@"登录" forState:UIControlStateNormal];
    [self.btn1 addTarget: self action:@selector(login3:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"btn_share_sina@2x"] forState:UIControlStateNormal];
    [self.view addSubview:self.btn1];

    
    
    

}
//第三方登录
-(void)login3:(UIButton *)btn{

    
    UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity * response){
        
        [[UMSocialDataService defaultDataService]requestSocialAccountWithCompletion:^(UMSocialResponseEntity *response) {
            
        }];
        
    });


}



-(void)login:(UIButton *)btn{
//   //post请求 拼接
//    NSString * str = @"http://mobile.itanzi.com/wap/api/Smslogincheck";
//    NSDictionary * dic = @{@"Password":self.field6,@"Phone":self.field5};
//    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager POST:str parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"登录成功");
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"获取失败");
//    }];
//
//    
//    NSLog(@"点我登录");

    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"鹏少正在维护系统，请用新浪微博登录" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    [alert show];
  
}
-(void)next:(UIButton *)btn{
    
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
