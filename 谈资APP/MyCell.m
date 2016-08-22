//
//  MyCell.m
//  谈资APP
//
//  Created by qianfeng on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyCell.h"
#import "Search.h"
#import "UIImageView+WebCache.h"
@implementation MyCell{

    UILabel * label;
    UILabel * label1;
    UIImageView * img;
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createCell];
        
    }
    return self;
}
-(void)createCell{

    label =  [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 200, 30)];
    //label.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:label];
    
    
    label1 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 60, 60, 30)];
   // label1.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:label1];
    
    img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 80)];
    img.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:img];

}
-(void)reciveData1:(Search *)model{
    NSString * name = [NSString stringWithFormat:@"%@",model.NewsTitle];
    label.text = name;
    
    NSString * name1 = [NSString stringWithFormat:@"%@",model.HasRead];
    label1.text = name1;
    
    
    model.ImageUrl = [model.ImageUrl stringByRemovingPercentEncoding];//转码 刚才是乱码
    [img sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl]];


}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
