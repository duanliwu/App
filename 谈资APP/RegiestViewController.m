//
//  RegiestViewController.m
//  谈资APP
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RegiestViewController.h"
#import "AFNetworking.h"
@interface RegiestViewController ()

@end

@implementation RegiestViewController

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
    self.field1 = [[UITextField alloc]initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 40)];
    self.field1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.field1];
    
    self.field2 = [[UITextField alloc]initWithFrame:CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, 40)];
    self.field2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.field2];
    
    self.field3 = [[UITextField alloc]initWithFrame:CGRectMake(0, 170, [UIScreen mainScreen].bounds.size.width, 40)];
    self.field3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.field3];
    
    
    NSArray * array = @[@"注册",@"获取验证码"];
     for(int i=0;i<2;i++){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((80+80)*i+50, 260, 100, 30);
         [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
         [btn setTitle:array[i] forState:UIControlStateNormal];
         btn.tag = 100+i;
        [btn addTarget: self action:@selector(xiayiye:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    
    }
    
}
-(void)xiayiye:(UIButton *)btn{
    //获取验证吗的按钮
    //采用post注册
    if(btn.tag == 101){
        NSLog(@"点我获取验证码");//这个只是获取验证码
        NSString * str = @"http://mobile.itanzi.com/wap/api/Smslogin";//获取验证码网址
    NSDictionary * dic = @{@"Phone":self.field1.text};//获取验证码只要把手机号拼接上
        
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        
       manager.responseSerializer = [AFHTTPResponseSerializer serializer];
       [manager POST:str parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
           NSLog(@"%@",responseObject);
           
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"获取失败");
       }];

    }
    else if(btn.tag == 100){
    
        //注册网址http://mobile.itanzi.com/wap/api/Smslogincheck
        NSLog(@"点我注册");//注册的时候需要把三项凭借上去
        NSString * str = @"http://mobile.itanzi.com/wap/api/Smslogincheck";
        NSDictionary * dic = @{@"Pass":self.field2,@"Password":self.field3,@"Phone":self.field1};
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:str parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
           //用block回调 把用户户名与密码显示到登录页面的文本框内
            //self.logBlock(self.field1,self.field2);
            NSLog(@"注册成功");
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"获取失败");
        }];
        
    


        
        
    
    }
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
