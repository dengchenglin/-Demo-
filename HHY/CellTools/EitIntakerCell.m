//
//  EitIntakerCell.m
//  HHY
//
//  Created by chenguangjiang on 14-11-11.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "EitIntakerCell.h"
#import "EitIntakerViewController.h"
@implementation EitIntakerCell

- (void)awakeFromNib {
    
}

-(void)setIntakerDic:(NSDictionary *)intakerDic
{
    if(_intakerDic != intakerDic)
    {
        _intakerDic = [intakerDic copy];
    }
    NSString *name = [_intakerDic objectForKey:@"name"];
    _intakeName.text = name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)eit {

    EitIntakerViewController *vc = [[EitIntakerViewController alloc]init];
    
    vc.intakerDic = _intakerDic;
    vc.index = _index;
    vc.intakerVC = _intakerVC;
    [_intakerVC.navigationController pushViewController:vc animated:YES];
}
@end
