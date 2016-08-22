//
//  PersonCenterViewController.m
//  谈资APP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "PersonCell.h"
#import "ShouCangViewController.h"
#import "RegiestViewController.h"//注册页面
#import "LoginViewController.h"//登录页面
#import "TuijianViewController.h"
#import "DiscussViewController.h"
@interface PersonCenterViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView * _tabV;
    NSMutableArray * _dataArr;

}

@end

@implementation PersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self createNavigation];
    [self createButton];
    [self createTableView];
    [self createData];
    self.view.backgroundColor = [UIColor grayColor];
    
    self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 150)];
    self.imageView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView1];
    
    self.imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(139, 90, 70, 70)];
   // self.imageView2.backgroundColor = [UIColor yellowColor];
    self.imageView2.image = [UIImage imageNamed:@"CommentHeader@2x"];
    [self.view addSubview:self.imageView2];
    
    
    
    NSArray * array = @[@"注册",@"登录"];
    //时间驱动型控件
    UISegmentedControl * segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.tintColor = [UIColor redColor];
    segment.frame = CGRectMake(130, 180, 100, 30);
    [segment addTarget:self action:@selector(changeObj:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    // Do any additional setup after loading the view.
}
//登录注册事件
-(void)changeObj:(UISegmentedControl *)seg{
    if(seg.selectedSegmentIndex == 0){
    
        RegiestViewController * reg = [[RegiestViewController alloc]init];
        [self.navigationController pushViewController:reg animated:YES];
    
    }else if (seg.selectedSegmentIndex == 1){
        LoginViewController * login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
}

-(void)createNavigation{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(150, 30, 80, 30)];
    self.label.text = @"个人中心";
    [self.view addSubview:self.label];
}
-(void)createButton{

    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(10,20, 40, 40);
    [self.button setImage:[UIImage imageNamed:@"home_back_button@2x"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageView addSubview:self.button];
}
-(void)back:(UIButton*)btn{
  
    [self dismissViewControllerAnimated:YES completion:nil];

}
//创建tableView
-(void)createTableView{
    _dataArr = [[NSMutableArray alloc]init];
    _tabV = [[UITableView alloc]initWithFrame:CGRectMake(0, 210, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-210)];
    _tabV.delegate = self;
    _tabV.dataSource = self;
    [self.view addSubview:_tabV];


}
-(void)createData{

    NSArray * array = @[@"我的收藏",@"我的评论",@"我的逗比",@"btn_collect_sel@2x",@"iconMyComment@2x",@"myNumber@2x"];
    [_dataArr addObject:array];
NSArray * array1 = @[@"消息推送",@"推荐",@"意见反馈",@"我的位置",@"iconPush@2x",@"iconRecommended@2x",@"iconFeedback@2x",@"iconEvaluation@2x"];
    
    [_dataArr addObject:array1];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;//给每一个区设置标头

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 3;
    }
    else
        return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cell";
    PersonCell * cellid = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cellid){
    
        cellid = [[PersonCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    if(indexPath.section == 0){
        [cellid reciveData:_dataArr[indexPath.section][indexPath.row] withImage:[UIImage imageNamed:_dataArr[indexPath.section][indexPath.row+3]]];
    }
    else if(indexPath.section == 1){
    
     [cellid reciveData:_dataArr[indexPath.section][indexPath.row] withImage:[UIImage imageNamed:_dataArr[indexPath.section][indexPath.row+4]]];
    
    }
     
    return cellid;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row== 0){
    
    ShouCangViewController * sc = [[ShouCangViewController alloc]init];
    sc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    sc.string = _dataArr[indexPath.section][indexPath.row];
    [self presentViewController:sc animated:YES completion:nil];
    }
    if(indexPath.section==1)
    {
        if(indexPath.row == 2){
    
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请联系鹏少" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alert show];
    }
        else if (indexPath.row == 3){
        
            DiscussViewController * dis = [[DiscussViewController alloc]init];
            [self.navigationController pushViewController:dis animated:YES];
        
        }
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
