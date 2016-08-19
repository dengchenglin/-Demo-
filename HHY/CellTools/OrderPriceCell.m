//
//  OrderPriceCell.m
//  HHY
//
//  Created by jiangjun on 14-5-19.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "OrderPriceCell.h"

@implementation OrderPriceCell

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
    _typeLable = [AffUIToolBar lableCgrectmake:CGRectMake(10, 5, 100, 20) lableNametext:@"经济舱9.5折"];
    _typeLable.textColor = [JJDevice colorWithR:100 G:100 B:100 A:1];
    _typeLable.font = FONT_14;
    _typeLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_typeLable];
    
    _priceLable = [AffUIToolBar lableCgrectmake:CGRectMake(180, 5, 60, 20) lableNametext:@"¥ 1220"];
    _priceLable.textColor = [JJDevice colorWithR:231 G:148 B:0 A:1];
    _priceLable.font = FONT_14;
    _priceLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_priceLable];
    
    _countLable = [AffUIToolBar lableCgrectmake:CGRectMake(200, 25, 40, 20) lableNametext:@"¥ 1220"];
    _countLable.textColor = [JJDevice colorWithR:136 G:136 B:136 A:1];
    _countLable.font = FONT_14;
    _countLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_countLable];
    
    _bookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _bookButton.backgroundColor = [JJDevice colorWithR:219 G:128 B:41 A:1];
    [_bookButton setTitle:@"预定" forState:UIControlStateNormal];
    _bookButton.layer.cornerRadius = 5;
    _bookButton.layer.masksToBounds = YES;
    _bookButton.frame = CGRectMake(250, 5, 60, 40);
    [self.contentView addSubview:_bookButton];
    
    _tuigaiguidingBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tuigaiguidingBT setFrame:CGRectMake(10, 25, 61, 23)];
    [_tuigaiguidingBT setBackgroundImage:[UIImage imageNamed:@"tuigaiguiding"] forState:UIControlStateNormal];
    [self.contentView addSubview:_tuigaiguidingBT];
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
