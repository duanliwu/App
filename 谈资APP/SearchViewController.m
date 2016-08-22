//
//  SearchViewController.m
//  谈资APP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SearchViewController.h"
#import "MyCell.h"
#import "AFNetworking.h"
#import "Search.h"
#import "DBSphereView.h"
#import "ALLModel.h"
#import "NewsTableViewCell.h"
#import "UIImageView+WebCache.h"

//http://mobile.itanzi.com/wap/api/k/%E7%94%B5%E5%BD%B1  //收索接口 只是k后面的不一样
@interface SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * _dataArr;
    DBSphereView * sphereView;
    UISearchBar * search;
    UITableView * _tabV;
    
    
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self createUI];

   
    
    // Do any additional setup after loading the view.
}
-(void)createUI{
    
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    search.placeholder = @"搜索:关键字";
    
    search.delegate = self;
    [search becomeFirstResponder];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:search];
    self.navigationItem.rightBarButtonItem = item;
    
    sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(20, 150, 320, 280)];
    NSMutableArray * array = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray * array1 = @[@"搞笑",@"奇葩",@"段子",@"饿了",@"创意",@"真相",@"电影",@"乖乖",@"摄影",@"美女"];
    for (NSInteger i = 0; i < 10; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        //[btn setTitle:[NSString stringWithFormat:@"P%ld按钮", i] forState:UIControlStateNormal];
        [btn setTitle:array1[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100. green:arc4random_uniform(100)/100. blue:arc4random_uniform(100)/100. alpha:1];
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=3;
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.frame = CGRectMake(0, 0, 50, 20);
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:btn];
        [sphereView addSubview:btn];
    }
    [sphereView setCloudTags:array];
    sphereView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sphereView];
  

}

- (void)buttonPressed:(UIButton *)btn
{
    NSLog(@"%@",btn.titleLabel.text);
    [sphereView timerStop];//动画效果
    [UIView animateWithDuration:2 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [sphereView timerStart];
        }];
    }];
    
    
    
    
    

}



-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"********%@",searchText);
    // sphereView.hidden = YES;
    _dataArr = [[NSMutableArray alloc]init];
    
    NSURL *url1 = [NSURL URLWithString: [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
   
//        NSString * url1 =@"http://mobile.itanzi.com/wap/api/k/";
        NSString * url = [NSString stringWithFormat:@"http://mobile.itanzi.com/wap/api/k/%@",url1];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      NSDictionary * dict = [responseObject objectForKey:@"Data"];
        NSArray * array = [dict objectForKey:@"list"];
        NSLog(@"%@",array);
        for(NSDictionary * di in array){
            Search * model = [[Search alloc]init];
            model.HasRead = [di objectForKey:@"HasRead"];
            model.ImageUrl = [di objectForKey:@"ImageUrl"];
            model.NewsTitle = [di objectForKey:@"NewsTitle"];
            
          // NSLog(@"%@",model.HasRead);
     
            [_dataArr addObject:model];
        }
        [_tabV reloadData];
        [self createtableView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

//创建tableVeiw
-(void)createtableView{
    
    _tabV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    _tabV.delegate = self;
    _tabV.dataSource = self;
    [self.view addSubview:_tabV];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *cellID = @"cell";
    MyCell * cellid = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cellid){
    
        cellid = [[MyCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    
    }

    
    [cellid reciveData1:_dataArr[indexPath.row]];
//    
//    Search * model = _dataArr[indexPath.row];
//    NSString * name = [NSString stringWithFormat:@"%@",model.NewsTitle];
//    cellid.textLabel.text = name;
//    
//    model.ImageUrl = [model.ImageUrl stringByRemovingPercentEncoding];//转码 刚才是乱码
    
    //[model.ImageUrl sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl]];
   // NSLog(@"-----%@",model.HasRead);
    return cellid;
}









-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//收索键盘按钮

     [searchBar becomeFirstResponder];
    //[self doSearch:searchBar];
}
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [[self view] endEditing:YES];
//}
//系统里面每一个控件都有协议方法 只要遵守了协议  都能实现协议里面的方法
//所以也可以在自己制定协议 让别人去执行 只要执行的话 就可以实现里面的协议与方法
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
