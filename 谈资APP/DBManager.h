//
//  DBManager.h
//  谈资APP
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  ALLModel;
@interface DBManager : NSObject

+(DBManager *)shareManager;

//插入数据  对模型进行操作
-(void)insertModel:(ALLModel *)model;

//删除数据
-(void)deleteModelWithId:(ALLModel *)model;

//更新数据
-(void)updateModel:(ALLModel *)model;

//拿到所有的数据
-(NSArray *)resultAllUsers;  //拿到的是一个数组

//查询一个数据是不是存在
-(BOOL)isExistsWithId:(ALLModel *)model;


@end
