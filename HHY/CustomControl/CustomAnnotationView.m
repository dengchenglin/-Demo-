//
//  CustomAnnotationView.m
//  HHY
//
//  Created by chenguangjiang on 14-11-15.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomAnnotation.h"
#import "UIImageView+WebCache.h"
@implementation CustomAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super init])
    {
        [self initView];
    }
    return self;
}

-(void)initView
{
    _hotelImageView = [[UIImageView alloc]init];
    _hotelName = [[UILabel alloc]init];
    _typeName = [[UILabel alloc]init];
    [self addSubview:_hotelImageView];
    [self addSubview:_hotelName];
    [self addSubview:_typeName];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CustomAnnotation *annotation = (CustomAnnotation *)self.annotation;

    NSString *hotelName = [annotation.hotelDic objectForKey:@"hotelName"];
    CGSize size = [hotelName sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 100)];
    [_hotelImageView setFrame:CGRectMake(5, (size.height + 35 - 60)/2, 60, 60)];
    [_hotelName setFrame:CGRectMake(70, 5, 200, size.height)];
    _hotelName.text = hotelName;
    
    
    if([annotation isKindOfClass:[CustomAnnotation class]])
    {
        NSString *hotelNum = [annotation.hotelDic objectForKey:@"hotel"];
        
        if(hotelNum != nil || hotelNum.length != 0)
        {
            NSString *imageUrlStr = [NSString stringWithFormat:@"http://www.huamin.com.hk/image/hotel/%@.jpg",hotelNum];
            
            
            [_hotelImageView setImageWithURL:[NSURL URLWithString:imageUrlStr]];
            
        }
        else
        {
            NSString *imageUrlStr = @"http://www.huamin.com.hk/image/hotel/nopic.jpg";
            
            [_hotelImageView setImageWithURL:[NSURL URLWithString:imageUrlStr]];
        }

    }
    
    self.image = [UIImage imageNamed:@"no"];
 
    
}
@end
