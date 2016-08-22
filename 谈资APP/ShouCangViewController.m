//
//  ShouCangViewController.m
//  谈资APP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ShouCangViewController.h"
#import "DBManager.h"
#import "NewsTableViewCell.h"
#import "ALLModel.h"
@interface ShouCangViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *array;
@end

@implementation ShouCangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    [self createUI];
    [self createTableView];
    [self initData];
}
-(void)createUI{
    self.navigationController.navigationBarHidden = YES;
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(150, 30, 80, 30)];
    self.label.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.label];
    
    self.label.text = self.string;
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 25, 40, 40);
    [button addTarget:self action:@selector(back1:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageView addSubview:button];

}
-(void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-64 ) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}
-(void)initData{
    self.array = [[NSMutableArray alloc] init];
    DBManager *db = [DBManager shareManager];
    NSLog(@"-----------%@",db);
    self.array = [db resultAllUsers];//调用方法 取出数组里面所有的元素 放入self.array这个数组
}
-(void)back1:(UIButton *)btn{

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString  * cellID = @"cell";
    NewsTableViewCell  * cellid = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cellid){
        cellid = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }//复用第一个页面里的cell
    ALLModel *amodel = self.array[indexPath.row];
    [cellid reciveData:amodel];
    return cellid;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
//实现4个方法  实现滑动删除  这四个方法老王都讲过  只是没有注意听 
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;

}
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
  return @"删除";

}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //单例
    DBManager * db = [DBManager shareManager];
    [db deleteModelWithId:_array[indexPath.row]];
    [self initData];
    [_tableView reloadData];//重新刷新一下
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"dfsa" message:@"删除成功" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    [alert show];

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
