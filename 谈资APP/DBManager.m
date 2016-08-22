//
//  DBManager.m
//  谈资APP
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//



//#import "NewModel.h"
#import "ALLModel.h"
#import "DBManager.h"
#import "FMDatabase.h"//这个第三方库 封装了一些常用的sql语句
@implementation DBManager{
    
    
    FMDatabase * _dataBase;  //实例化一个对象
}
//static修饰的变量 只会初始化一次 以后再调用这个方法 这个变量会一直持有第一次初始化的值
static DBManager * manager = nil;
+(DBManager *)shareManager{
    
    if(manager == nil){
        manager = [[DBManager alloc]init];
    }
    return manager;
}
//重写init方法
-(instancetype)init{
    if(self = [super init]){
        NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.db"];//创建一个路径
        _dataBase = [[FMDatabase alloc]initWithPath:path];
        NSLog(@"%@",path);
        //表的名字应该是userInfo1    存储在.data这个
        if([_dataBase open]){ //open如果本地有数据就打开 没有的话创建并打开
            NSString * createSql = @"create table if not exists userInfo1(NewsTitle varchar(256),ImageUrl varchar(256))";
            BOOL isSuccess = [_dataBase executeUpdate:createSql];
            
            if(!isSuccess){
                NSLog(@"------------%@",_dataBase.lastErrorMessage);//打印错误信息
            }
            NSLog(@"创建成功");
        }
    }
    return self;
}
//插入数据
-(void)insertModel:(ALLModel*)model{
    NSString * insertSql = @"insert into userInfo1(NewsTitle,ImageUrl) values(?,?)";
    NSLog(@"%@ %@",model.NewsTitle,model.ImageUrl);
    BOOL isSuccess = [_dataBase executeUpdate:insertSql,model.NewsTitle,model.ImageUrl];
    if(!isSuccess){
        NSLog(@"%@",_dataBase.lastErrorMessage);
        NSLog(@"插入失败");
    }else{
        NSLog(@"插入成功");
    }
    
}
//删除
-(void)deleteModelWithId:(ALLModel *)model{
    NSString * deleteSql = @"delete from userInfo1 where NewsTitle = ? and ImageUrl = ?";//这个？是占位符
    BOOL isSuccess = [_dataBase executeUpdate:deleteSql,model.NewsTitle,model.ImageUrl];
    if(!isSuccess){
        NSLog(@"%@",_dataBase.lastErrorMessage);
    }
}
//更新 根据id更新新的数据
-(void)updateModel:(ALLModel *)model{
    //应该是有三个参数
    NSString * updateSql = @"update userInfo1 where NewsTitle=?,ImageUrl =?";
    
    BOOL isSuccess = [_dataBase executeUpdate:updateSql,model.NewsTitle,model.ImageUrl];
    if(!isSuccess){
        NSLog(@"%@",_dataBase.lastErrorMessage);
    }
}
//查询所有
-(NSArray *)resultAllUsers{
    //查询所有
    NSString * resultSql = @"select * from userInfo1";
    
    //查询结果的集合
    //executeQuery查询数据
    FMResultSet * resultSet = [_dataBase executeQuery:resultSql];
    NSMutableArray * dataArr = [[NSMutableArray alloc]init ];
    while ([resultSet next]) {
        ALLModel * model = [[ALLModel alloc]init];
        model.NewsTitle = [resultSet stringForColumn:@"NewsTitle"];
        model.ImageUrl = [resultSet stringForColumn:@"ImageUrl"];
        [dataArr addObject:model];
        NSLog(@"fasdfes%@",model.NewsTitle);
    }
    NSLog(@"%@",dataArr);
    return dataArr;
}
-(BOOL)isExistsWithId:(ALLModel *)model{
    
    NSString * existsSql = @"select * from userInfo1 where NewsTitle=? and ImageUrl =?";
    FMResultSet * set = [_dataBase executeQuery:existsSql,model.NewsTitle,model.ImageUrl];
    if([set next]){
        return YES;
    }
    else {
        return NO;
    }
    
}

@end
