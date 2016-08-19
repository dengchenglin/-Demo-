//
//  CodeCell.m
//  AutoLayoutDemo
//
//  Created by chenguangjiang on 15/10/22.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "CodeCell.h"

@implementation CodeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self createView];
    }
    return self;
}
-(void)createView{
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_topView];
    
    _centerView = [[UIView alloc]init];
    _centerView.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:_centerView];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.backgroundColor = [UIColor yellowColor];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:17];

    [self.contentView addSubview:_contentLabel];
    
    _bottonView = [[UILabel alloc]init];
    _bottonView.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:_bottonView];
    
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        make.height.equalTo(@(30));
    }];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        //与下面两个相同
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.leading.equalTo(_topView);
        make.top.equalTo(_topView.mas_bottom).offset(10);
        make.right.equalTo(_contentLabel.mas_left).offset(-10);
        make.bottom.equalTo(_bottonView.mas_top).offset(-10);
       // make.width.equalTo(@80);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).offset(10);
        make.right.equalTo(@(-10));
        make.bottom.equalTo(_bottonView.mas_top).offset(-10);
    }];
    [_bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.bottom.equalTo(@(-10));
        make.height.equalTo(@30);
    }];
    
}

-(void)fillData:(NSString *)content{
    
    _contentLabel.text = content;
    _contentLabel.preferredMaxLayoutWidth = 210;
    [self updateConstraintsIfNeeded];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
