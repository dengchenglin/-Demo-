//
//  CodeCell.h
//  AutoLayoutDemo
//
//  Created by chenguangjiang on 15/10/22.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CodeCell : UITableViewCell
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIView *centerView;
@property(nonatomic,strong)UIView *bottonView;
@property(nonatomic,strong)UILabel *contentLabel;
-(void)fillData:(NSString *)content;
@end
