//
//  PersonCell.m
//  谈资APP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PersonCell.h"

@implementation PersonCell{

    UILabel * label ;
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
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    //imageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:imageView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 100, 30)];
    //label.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:label];
    


}
-(void)reciveData:(NSString *)string withImage:(UIImage *)image{

    label.text = string;
    imageView.image = image;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
