//
//  PassangerCell.h
//  HHY
//
//  Created by jiangjun on 14-6-3.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassangerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *shenfengzhen;
@property (weak, nonatomic) IBOutlet UILabel *nameText;
@property (weak, nonatomic) IBOutlet UILabel *sfzText;
@property (weak, nonatomic) IBOutlet UIImageView *deleteImageView;
-(void)chushihua;
@end
