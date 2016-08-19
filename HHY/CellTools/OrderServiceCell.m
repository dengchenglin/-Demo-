//
//  OrderServiceCell.m
//  HHY
//
//  Created by chenguangjiang on 14-11-10.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "OrderServiceCell.h"
#import "HotelOrderParameter.h"
#import "IntakerViewController.h"
@implementation OrderServiceCell
{
    CustomPickView *_pickView;
    NSMutableArray *_saveDataArr;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

- (void)awakeFromNib {
   
   _pickView = [[[NSBundle mainBundle] loadNibNamed:@"CustomPickView" owner:self options:nil] lastObject];
    _pickView.delegate = self;
    _saveDataArr = [[NSMutableArray alloc]init];
    for (id obj in self.subviews)
        if ([NSStringFromClass([obj class])isEqualToString:@"UITableViewCellScrollView"])
        {
            UIScrollView *scroll = (UIScrollView *) obj;
            scroll.delaysContentTouches = NO;
            break;
        }
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenKeyboard) name:@"hiddenkeyboard" object:nil];
}
-(void)layoutSubviews{
    _intakerName.delegate = _fillOrderVC;
    _intakerName.tag = _roomcount + 600;
}

-(NSNumber*)refreshView:(NSArray *)servelist
{
    
    for(UIView *v in _serviceView.subviews)
    {
        [v removeFromSuperview];
    }
    CGFloat height = 0;
    for(int i = 0; i < servelist.count;i++)
    {
        NSDictionary *dic = [servelist objectAtIndex:i];
        UIView *view =[[UIView alloc]init];
        UILabel *serviceName = [[UILabel alloc]init];
        serviceName.text = [dic objectForKey:@"servName"];
        CGSize size = [serviceName.text sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(60, 200)];
        
        if(size.height > 30)
        {
            [serviceName setFrame:CGRectMake(40, 2, 60, size.height)];
            [view setFrame:CGRectMake(0, height, 320, size.height +4)];
            height = height + size.height + 4;
        }
        else
        {
            [serviceName setFrame:CGRectMake(40, 2, 60, 30)];
            [view setFrame:CGRectMake(0, height, 320, 34)];
            height = height + 34;
        }
        
        serviceName.textColor = kADWColor(100, 100, 100, 1);
        serviceName.font = [UIFont systemFontOfSize:11];
        serviceName.numberOfLines = 0;
        [view addSubview:serviceName];
        UIButton *selectBut= [UIButton buttonWithType:UIButtonTypeCustom];
        selectBut.tag = 50 + i;
        [selectBut setFrame:CGRectMake(20, (view.frame.size.height - 21)/2, 20, 20)];
        [selectBut setBackgroundImage:[UIImage imageNamed:@"air_cb_normal"] forState:UIControlStateNormal];
   
        [selectBut setBackgroundImage:[UIImage imageNamed:@"air_cb_checked"] forState:UIControlStateSelected];
        [selectBut addTarget:self action:@selector(selectAct:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:selectBut];
        UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(120, (view.frame.size.height - 26)/2, 50, 26)];
        price.text = [NSString stringWithFormat:@"单价:%@",[dic objectForKey:@"price"]];
        price.font = [UIFont systemFontOfSize:12];
        price.textColor = kADWColor(244, 119, 11, 1);
        [view addSubview:price];
        UIButton *partBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [partBut setFrame:CGRectMake(200, (view.frame.size.height - 18)/2, 18, 18)];
        partBut.tag = 100 + i;
        [partBut.layer setBorderWidth:1];
        [partBut.layer setBorderColor:kADWColor(220, 220, 220, 1).CGColor];
      
        [partBut setTitleColor:kADWColor(50, 50, 50, 1) forState:UIControlStateNormal];
        partBut.titleLabel.font = [UIFont systemFontOfSize:12];
        [partBut setTitle:@"1" forState:UIControlStateNormal];
        [partBut addTarget:self action:@selector(selectPartCount:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:partBut];
        UILabel *maxPart = [[UILabel alloc]initWithFrame:CGRectMake(221, (view.frame.size.height-20)/2, 65, 20)];
        maxPart.text = @"/份";
        maxPart.textColor = kADWColor(80, 80, 80, 1);
        maxPart.font = [UIFont systemFontOfSize:11];
        [view addSubview:maxPart];
        
        UIButton *nightBut = [UIButton buttonWithType:UIButtonTypeCustom];
        nightBut.tag = 200 + i;
        [nightBut setFrame:CGRectMake(265, (view.frame.size.height-18)/2, 18, 18)];
        [nightBut.layer setBorderWidth:1];
        [nightBut.layer setBorderColor:kADWColor(220, 220, 220, 1).CGColor];
         nightBut.titleLabel.font = [UIFont systemFontOfSize:12];
        [nightBut setTitleColor:kADWColor(50, 50, 50, 1) forState:UIControlStateNormal];
        [nightBut setTitle:@"1" forState:UIControlStateNormal];
        [nightBut addTarget:self action:@selector(selectNightCount:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:nightBut];
        
        UILabel *nightLabel = [[UILabel alloc]initWithFrame:CGRectMake(286, (view.frame.size.height-20)/2, 20, 20)];
        nightLabel.text = @"晚";
        nightLabel.textColor = kADWColor(80, 80, 80, 1);
        nightLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:nightLabel];
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(15, view.frame.size.height - 1, 290, 1)];
        line.backgroundColor = kADWColor(220, 220, 220, 1);
        [view addSubview:line];
        if(i == servelist.count - 1)
        {
            [line setFrame:CGRectMake(0, view.frame.size.height - 1, 320, 1)];
        }
        [_serviceView addSubview:view];
        
        
        
  
        if(_saveDataArr.count != 0)
        {
         
            NSDictionary *d = [_saveDataArr objectAtIndex:i];
            NSString *isSelect =[d objectForKey:@"selected"];
            if([isSelect isEqualToString:@"1"])
            {
                selectBut.selected = YES;
            }
            else
            {
                selectBut.selected = NO;
            }
            [partBut setTitle:[d objectForKey:@"partTitle"] forState:UIControlStateNormal];
            [nightBut setTitle:[d objectForKey:@"nightTitle"] forState:UIControlStateNormal];
        }
        
    }
    
    _serviceView.frame = CGRectMake(0, 30, 320, height);

    
    return @(35 + height);
}
- (IBAction)addIntaker {
    IntakerViewController *ctl = [[IntakerViewController alloc]init];
    ctl.delegate = self;
    if(_fillOrderVC)
    {
        [_fillOrderVC.navigationController pushViewController:ctl animated:YES];
    }
}

//是否选中该项服务
-(void)selectAct:(UIButton *)button
{
    if(button.selected)
    {
        button.selected = NO;
    }
    else
    {
        button.selected = YES;
    }
    [self compositePart];
    [self countSevAmount];
}
//点击份数
-(void)selectPartCount:(UIButton *)button
{
    NSDictionary *dic = [_serviceList objectAtIndex:button.tag - 100];
    NSInteger count = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"max"]] integerValue];
    NSMutableArray *arr = [NSMutableArray array];
    for(int i = 1;i <= count;i++)
    {
        [arr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    _pickView.arr = arr;
    _pickView.tag = button.tag;
    _pickView.titleLabel.text = @"选择份数";
    [_pickView show:_fillOrderVC];
}
//点击晚数
-(void)selectNightCount:(UIButton *)button
{
    NSMutableArray *arr = [NSMutableArray array];
    for(int i = 1;i <= _nightCount ;i++)
    {
        [arr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    _pickView.arr = arr;
    _pickView.tag = button.tag;
    _pickView.titleLabel.text = @"选择晚数";
    [_pickView show:_fillOrderVC];
}




//选中份数或晚数后
-(void)didSelectIndexRow:(NSString *)row withButTag:(NSInteger)tag
{
    UIButton *but = (UIButton *)[self.contentView viewWithTag:tag];
    if(but.tag < 200)
    {
        NSString *newRow = [NSString stringWithFormat:@"%d",[row intValue]+1];
        [but setTitle:newRow forState:UIControlStateNormal];
    }
    if(but.tag >= 200)
    {
        NSString *newRow = [NSString stringWithFormat:@"%d",[row intValue]+1];
        [but setTitle:newRow forState:UIControlStateNormal];
    }
    
    [self compositePart];
    [self countSevAmount];
}

//拼接服务项目
-(void)compositePart
{
    
    if(_saveDataArr.count != 0)
    {
        [_saveDataArr removeAllObjects];
    }
    NSMutableString *compostieStr = [NSMutableString string];
    for(int i = 0;i < _serviceList.count;i++)
    {
        UIButton *selectBut = (UIButton *)[self.contentView viewWithTag:50 + i];
        UIButton *partBut = (UIButton *)[self.contentView viewWithTag:100 + i];
        UIButton *nightBut = (UIButton *)[self.contentView viewWithTag:200 + i];
        NSDictionary *dic =[_serviceList objectAtIndex:i];
        NSString *serviceID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        if(selectBut.selected)
        {
            NSString *subService = [NSString stringWithFormat:@"%@_%@_%@",serviceID,partBut.titleLabel.text,nightBut.titleLabel.text];
            [compostieStr appendString:subService];
            [compostieStr appendString:@","];
        }
        
    //保存数据状态
        NSMutableDictionary *d  = [NSMutableDictionary dictionary];
        if(selectBut.selected)
        {
            [d setObject:@"1" forKey:@"selected"];
        }
        else
        {
            [d setObject:@"0" forKey:@"selected"];
        }
        [d setObject:partBut.titleLabel.text forKey:@"partTitle"];
        [d setObject:nightBut.titleLabel.text forKey:@"nightTitle"];
        [_saveDataArr addObject:d];
        
    }
   


    if(compostieStr.length != 0)
    {
        [compostieStr deleteCharactersInRange:NSMakeRange(compostieStr.length - 1, 1)];
    }
    [[HotelOrderParameter shareOrderParameter].serviceDic setObject:compostieStr forKey:[NSNumber numberWithInteger:_roomcount]];
 
    [[HotelOrderParameter shareOrderParameter] refreshServiceDic];
}




//计算服务金额
-(void)countSevAmount
{
    if(_saveDataArr.count != 0)
    {
        [_saveDataArr removeAllObjects];
    }
    CGFloat totalPrice = 0.00f;
    for(int tag = 0;tag < _serviceList.count;tag ++)
    {
        UIButton *selectBut = (UIButton *)[self.contentView viewWithTag:50 + tag];
        UIButton *partBut = (UIButton *)[self.contentView viewWithTag:100 + tag];
        UIButton *nightBut = (UIButton *)[self.contentView viewWithTag:200 + tag];
        
        NSDictionary *dic = [_serviceList objectAtIndex:tag];
        CGFloat price = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] floatValue];
        
        NSInteger partCount = [partBut.titleLabel.text integerValue];
        NSInteger nightCount = [nightBut.titleLabel.text integerValue];
        if(selectBut.selected)
        {
            totalPrice = totalPrice + partCount *price *nightCount;
        }
        
        
        //保存数据状态
     
        NSMutableDictionary *d  = [NSMutableDictionary dictionary];
        if(selectBut.selected)
        {
            [d setObject:@"1" forKey:@"selected"];
        }
        else
        {
            [d setObject:@"0" forKey:@"selected"];
        }
        [d setObject:partBut.titleLabel.text forKey:@"partTitle"];
        [d setObject:nightBut.titleLabel.text forKey:@"nightTitle"];
        [_saveDataArr addObject:d];
        
    }
    NSNumber *number = [NSNumber numberWithFloat:totalPrice];
    [[HotelOrderParameter shareOrderParameter].sevpriceDic setObject:number forKey:[NSNumber numberWithInteger:_roomcount]];
    [[HotelOrderParameter shareOrderParameter] refreshSerPriceDic];
    
}


-(void)hiddenKeyboard{
    for(UITextField *textfield in self.contentView.subviews)
    {
        [textfield resignFirstResponder];
    }
}


@end
