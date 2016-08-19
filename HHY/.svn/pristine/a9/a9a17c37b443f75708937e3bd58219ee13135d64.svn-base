//
//  CYCJRCell.m
//  HHY
//
//  Created by jiangjun on 14-5-12.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "CYCJRCell.h"

@implementation CYCJRCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self getCell];
    }
    return self;
}

-(void)getCell
{
    NSArray *array = @[@"姓   名",@"身份证"];
    for (int i=0; i<2; i++) {
//        UIImageView *lineView = [AffUIToolBar imageviewRect:CGRectMake(0, i*59, 320, 1) andimage:[UIImage imageNamed:@"xian"]];
//        [self.contentView addSubview:lineView];
        
        UILabel *lable = [AffUIToolBar lableCgrectmake:CGRectMake(5, i*30, 60, 30) lableNametext:[array objectAtIndex:i]];
        lable.textColor = [JJDevice colorWithR:9 G:9 B:9 A:1];
        [self.contentView addSubview:lable];
    }
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 200, 30)];
    _userName.textColor = [JJDevice colorWithR:143 G:143 B:143 A:1];
    [self.contentView addSubview:_userName];
    
    _shenfengzheng = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 200, 30)];
    _shenfengzheng.textColor = [JJDevice colorWithR:143 G:143 B:143 A:1];
    [self.contentView addSubview:_shenfengzheng];
    
    UIImageView *rightAllow = [AffUIToolBar imageviewRect:CGRectMake(280, 24, 12, 12) andimage:[UIImage imageNamed:@"rightarrow"]];
    [self.contentView addSubview:rightAllow];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
