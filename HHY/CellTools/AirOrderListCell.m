//
//  AirOrderListCell.m
//  HHY
//
//  Created by jiangjun on 14-6-6.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "AirOrderListCell.h"

@implementation AirOrderListCell

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
    _orderNumLable = [self lable:CGRectMake(20, 10, 240, 20)];
    _orderNumLable.text = @"订 单 号: 123456677888";
    _orderNumLable.font = FONT_15;
//    _orderNumLable.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.contentView addSubview:_orderNumLable];
    
    _stateLable = [[UILabel alloc] initWithFrame:CGRectMake(260, 5, 60, 20)];
    _stateLable.textColor = [UIColor whiteColor];
    _stateLable.backgroundColor = [JJDevice colorWithR:191 G:191 B:191 A:1];
    _stateLable.text = @"已取消";
    _stateLable.font = FONT_12;
    _stateLable.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    _stateLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_stateLable];
    
    _orderPriceCount = [self lable:CGRectMake(20, self.frame.size.height-20, 70, 20)];
    _orderPriceCount.text = @"订单总额:";
    _orderPriceCount.font = FONT_14;
    _orderPriceCount.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.contentView addSubview:_orderPriceCount];
    
    _priceLable = [self lable:CGRectMake(100, self.frame.size.height-20, 200, 20)];
    _priceLable.textColor = [JJDevice colorWithR:216 G:114 B:0 A:1];
    _priceLable.text = @"¥ 3128";
    _priceLable.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.contentView addSubview:_priceLable];
    
//    _rightView = [AffUIToolBar imageviewRect:CGRectMake(291, (self.frame.size.height-18)/2, 9, 12*1.5) andimage:[UIImage imageNamed:@"rightarrow"]];
//    _rightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//    [self.contentView addSubview:_rightView];
}

-(UILabel *)lable:(CGRect)frame
{
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    lable.textColor = [JJDevice colorWithR:143 G:143 B:143 A:1];
    return lable;
}

-(void)changeFrame
{
    self.rightView.frame = CGRectMake(291, (self.frame.size.height-18)/2, 9, 12*1.5);
    self.orderPriceCount.frame = CGRectMake(20, self.contentView.frame.size.height-20, 70, 20);
    self.priceLable.frame = CGRectMake(100, self.frame.size.height-20, 200, 20);
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
