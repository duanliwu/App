//
//  NewsTableViewCell.m
//  谈资APP
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation NewsTableViewCell{


    UILabel * label;
    UILabel * label1;
    UIImageView * imageView;

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
    
   
    label = [[UILabel alloc]initWithFrame:CGRectMake(100,10, 300, 80)];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    [self.contentView addSubview:label];
    
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(280, 70, 80,20)];
    label1.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:label1];
    
    
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 80, 80)];
    imageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:imageView];

  
}
-(void)reciveData:(ALLModel *)model{
    label.text = model.NewsTitle;
    label1.text = [NSString stringWithFormat:@"阅读 %@",model.HasRead];
    model.ImageUrl = [model.ImageUrl stringByRemovingPercentEncoding];//转码 刚才是乱码
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl]];
 }
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
