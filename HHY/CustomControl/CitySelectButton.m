//
//  CitySelectButton.m
//  HHY
//
//  Created by jiangjun on 14-5-14.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "CitySelectButton.h"

@implementation CitySelectButton
{
    UILabel *_daylabel;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createButton];
        //[self setBackgroundImage:[UIImage imageNamed:@"btClick"] forState:UIControlStateHighlighted];
    }
    return self;
}

-(void)createButton
{
    _daylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, self.frame.size.height)];

    _daylabel.font = [UIFont systemFontOfSize:14];
   // [self addSubview:_daylabel];
    _dateLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, self.frame.size.width-50, self.frame.size.height/2)];
    _dateLable.backgroundColor = [UIColor clearColor];
    _dateLable.font = [UIFont systemFontOfSize:14];
    [self addSubview:_dateLable];
    
    _yearLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2, self.frame.size.width-50, self.frame.size.height/2)];
    _yearLable.backgroundColor = [UIColor clearColor];
    _yearLable.font = [UIFont systemFontOfSize:12];
    [self addSubview:_yearLable];
    
    _rightView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-30, (self.frame.size.height-12)/2, 6, 12)];
    _rightView.image = [UIImage imageNamed:@"rightarrow"];
    [self addSubview:_rightView];
}

-(void)decideIsToday:(NSString *)descripition
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    NSString *nowdate =[dateformatter stringFromDate:date];
    long int longdate1 = [nowdate intValue];

    
    NSString *newdate = [descripition stringByReplacingOccurrencesOfString:@"-" withString:@""];

     long int longdate2 = [newdate intValue];

   
    
    _daylabel.hidden = NO;
    if(longdate2 == longdate1)
    {
        _daylabel.text = @"今天";
    }
    else if(longdate2 - longdate1 == 1)
    {
        _daylabel.text = @"明天";
    }
    else if(longdate2 - longdate1 == 2)
    {
        _daylabel.text = @"后天";
    }
    else
    {
        _daylabel.hidden = YES;
    }
    
}

-(void)removeAllViews
{
    [_dateLable removeFromSuperview];
    [_yearLable removeFromSuperview];
    [_rightView removeFromSuperview];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
