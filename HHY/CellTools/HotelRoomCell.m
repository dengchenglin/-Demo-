//
//  HotelRoomCell.m
//  HHY
//
//  Created by chenguangjiang on 14-11-5.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HotelRoomCell.h"

@implementation HotelRoomCell
{
     CustomPickView *_pickView;
}
- (void)awakeFromNib
{
    [_catCountBUt.layer setBorderWidth:1];
    [_catCountBUt.layer setBorderColor:kADWColor(220, 220, 220, 1).CGColor];
    [_reserveBut.layer setCornerRadius:4];
    
    _pickView = [[[NSBundle mainBundle] loadNibNamed:@"CustomPickView" owner:self options:nil] lastObject];
    _pickView.delegate = self;

   
}

-(void)setBf:(NSString *)bf
{
    if(_bf != bf)
    {
        _bf = [bf copy];
    }
 
    if([_bf isEqualToString:@"0"])
    {
       self.cerealCount.text = @"无早餐";
    }
    else
    {
       self.cerealCount.text = [NSString stringWithFormat:@"早餐%@份",_bf];
    }
}

-(void)setRoomDic:(NSDictionary *)roomDic
{
    if(_roomDic != roomDic)
    {
        _roomDic = [roomDic copy];
    }
    NSInteger advance = [[NSString stringWithFormat:@"%@",[_roomDic objectForKey:@"advance"]] integerValue];
    NSString *bookFlg = [NSString stringWithFormat:@"%@",[_roomDic objectForKey:@"bookFlg"]] ;
    NSLog(@"%d",advance);
    NSLog(@"%d",[self getNightcount:_startDate]);
    if([self getNightcount:_startDate] >= advance && ![bookFlg isEqualToString:@"0"])
    {
        _reserveBut.enabled = YES;
        _reserveBut.backgroundColor = kADWColor(253, 129, 25, 1);
    }
    else
    {
        _reserveBut.enabled = NO;
        _reserveBut.backgroundColor = [UIColor grayColor];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)reserve {
    
   
    [_hotelDetailVC reserveWithRoomID:_roomID andRoomNum:_catCountBUt.titleLabel.text andRoomDic:_roomDic andHotelName:_hotelName];
    
}

- (IBAction)catCount {
    
    NSMutableArray *arr = [NSMutableArray array];
    for(int i = 1;i <= 4;i++)
    {
        [arr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    _pickView.arr = arr;
    _pickView.titleLabel.text = @"选择房间数";
    [_pickView show:_hotelDetailVC];
    
    
}

-(void)didSelectIndexRow:(NSString *)row withButTag:(NSInteger)tag{
    
    [_catCountBUt setTitle:[NSString stringWithFormat:@"%d",[row integerValue] + 1] forState:UIControlStateNormal];
}

-(NSInteger)getNightcount:(NSString *)dateStr
{
    
    NSDateFormatter *forrmatter = [[NSDateFormatter alloc]init];
    [forrmatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *startDate = [forrmatter dateFromString:dateStr];
    NSDate *nowDate = [NSDate date];
    
    NSLog(@"%@  %@",startDate,nowDate);
    NSTimeInterval time = [startDate timeIntervalSinceDate:nowDate];
    NSLog(@"%f",time);
    return  ((NSInteger)time)/(3600 * 24);
    
}
@end
