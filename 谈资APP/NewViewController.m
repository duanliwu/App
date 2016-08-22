//
//  NewViewController.m
//  谈资APP
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewViewController.h"
#import "AFNetworking.h"
#import "ALLModel.h"
#import "NewsTableViewCell.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
@interface NewViewController()<UITableViewDataSource,UITableViewDelegate>{

    UITableView * _tabV;
    NSMutableArray * _dataArr;
    
    NSInteger  _page;
    BOOL _isfresh;
    UILabel * label;
    
    
    UIImageView * imageView;
    
}

@end
@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBar.tintColor = [UIColor redColor];
    _tabV = [[UITableView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _dataArr = [[NSMutableArray alloc]init];
    _tabV.delegate = self;
    _tabV.dataSource = self;
    [self.view addSubview:_tabV];
    //_page = 1; 设置当前页的页数是第几页
    [self createData];
    [self createFresh];
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    imageView.backgroundColor = [UIColor redColor];
    _tabV.tableHeaderView = imageView;
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0,115, [UIScreen mainScreen].bounds.size.width, 30)];
    label.textColor = [UIColor blackColor];
    [imageView addSubview:label];


    
   
}




-(void)createFresh{
    [_tabV addHeaderWithTarget:self action:@selector(xiala)];
    [_tabV addFooterWithTarget:self action:@selector(shangla)];
}
-(void)xiala{
    _page = 1;
    _isfresh = YES;
    //重新请求数据
    [self createData];
    [_tabV headerEndRefreshing];
}
-(void)shangla{
    _isfresh = NO;
    _page ++;
    [self createData];
    [_tabV footerEndRefreshing];
    
}

-(void)createData{
    
    //滑动的几个页面都是继承与第一个页面

    
    //self.string = [NSString stringWithFormat:@"http://mobile.itanzi.com/wap/api/NewsList/0/%d/10",(int)_page];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:self.string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       NSDictionary * dict = [responseObject objectForKey:@"Data"];
       NSArray * array = [dict objectForKey:@"Normal"];
       NSArray * array1 = [dict objectForKey:@"Hot"];
       for(NSDictionary * dict in array){
           ALLModel * model = [[ALLModel alloc]init];
           model.NewsTitle = [dict objectForKey:@"NewsTitle"];
           model.ImageUrl = [dict objectForKey:@"ImageUrl"];
           model.HasRead = [dict objectForKey:@"HasRead"];
           model.ContentUrl = [dict objectForKey:@"ContentUrl"];
           model.NewsId = [dict objectForKey:@"NewsId"];
           [_dataArr addObject:model];
       }
       for(NSDictionary * di in array1){
           ALLModel * model = [[ALLModel alloc]init];
           model.ImageUrl = [di objectForKey:@"ImageUrl"];
           model.NewsTitle = [di objectForKey:@"NewsTitle"];
           model.ImageUrl = [model.ImageUrl stringByRemovingPercentEncoding];//转码 刚才是乱码
           [imageView sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl]];
           label.text = model.NewsTitle;
           
       }
      
       
    [_tabV reloadData];
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
   }];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController * det = [[DetailViewController alloc]init];
    UINavigationController * una = [[UINavigationController alloc]initWithRootViewController:det];
    det.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    ALLModel * model = _dataArr[indexPath.row];//取出模型
    det.DetailStr = model.NewsId;
    
    det.model = model;//取出点击模型的详情页面
    
    [self.navigationController presentViewController:una animated:YES completion:nil];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString  * cellID = @"cell";
    NewsTableViewCell  * cellid = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cellid){
        cellid = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    
    }
    [cellid reciveData:_dataArr[indexPath.row]];
    return cellid;
    

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
