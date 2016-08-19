//
//  AirPlainInfoCell.m
//  HHY
//
//  Created by jiangjun on 14-6-3.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "AirPlainInfoCell.h"

@implementation AirPlainInfoCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)tuigaiShow {
    
    [[HHYNetworkEngine sharedInstance] getQuitRuleWithAirCode:nil andSpace:nil block:^(NSError *error ,id data){
        
    }];
 
}
@end












