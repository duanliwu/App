//
//  TitleViewController.m
//  谈资APP
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TitleViewController.h"

#import "NewViewController.h"
#import "HotViewController.h"
#import "RandomViewController.h"
#import "ShenBaViewController.h"
#import "GanHuoViewController.h"
#import "LafViewController.h"
#import "PlayViewController.h"
#import "GoodViewController.h"
#import "MengMengViewController.h"
#import "SCNavTabBarController.h"
#import "PersonCenterViewController.h"
#import "SearchViewController.h"
@interface TitleViewController ()

@end

@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //改变导航栏的背景颜色
   // self.navigationController.navigationBarHidden = YES;
   // self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.788  green:0.149  blue:0.114 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    NewViewController * new = [[NewViewController alloc]init];
    new.title = @"最新";
    new.string = @"http://mobile.itanzi.com/wap/api/NewsList/0/0/10";
    
    HotViewController * hot = [[HotViewController alloc]init];
    hot.title = @"最热";
    hot.string = @"http://mobile.itanzi.com/wap/api/NewsList/1/0/10";

    
    
    RandomViewController * random = [[RandomViewController alloc]init];
    random.title = @"随机";
    random.string = @"http://mobile.itanzi.com/wap/api/NewsList/2/0/10";
    
  
    
    GanHuoViewController * ganhuo = [[GanHuoViewController alloc]init];
    ganhuo.title = @"干活";
    ganhuo.string = @"http://mobile.itanzi.com/wap/api/NewsList/20/0/10";
    
    LafViewController * laf = [[LafViewController alloc]init];
    laf.title = @"搞笑";
    //laf.string = @"http://mobile.itanzi.com/wap/api/NewsList/21/0/10";
    
    PlayViewController * play = [[PlayViewController alloc]init];
    play.title = @"娱乐";
    //play.string = @"http://mobile.itanzi.com/wap/api/NewsList/22/0/10";

    
    
    SCNavTabBarController * navTab = [[SCNavTabBarController alloc]init];
    navTab.subViewControllers = @[new,hot,random,ganhuo,laf,play];
    navTab.showArrowButton = NO;
    [navTab addParentController:self];
    [self createButton];

    // Do any additional setup after loading the view.
}
-(void)createButton{

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(150, 10, 40, 40);
   // button.backgroundColor = [UIColor grayColor];
    [button setBackgroundImage:[UIImage imageNamed:@"home_tabbar_icon_user@2x"] forState:UIControlStateNormal];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 101;
    self.navigationItem.leftBarButtonItem = item;
    
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(300, 20,40, 40);
    // button.backgroundColor = [UIColor grayColor];
    [button1 setBackgroundImage:[UIImage imageNamed:@"home_titlebar_search@2x"] forState:UIControlStateNormal];
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = 102;
    self.navigationItem.rightBarButtonItem = item1;

}
-(void)next:(UIButton *)btn{

    if(btn.tag == 101){
    
    PersonCenterViewController * Pc  = [[PersonCenterViewController alloc]init];
    UINavigationController * una = [[UINavigationController alloc]initWithRootViewController:Pc];
    Pc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentViewController:una animated:YES completion:nil];
    }
    if(btn.tag == 102){
        SearchViewController * search = [[SearchViewController alloc]init];
        
        search.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self.navigationController pushViewController:search animated:YES];

    
    
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
