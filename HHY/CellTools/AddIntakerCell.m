//
//  AddIntakerCell.m
//  HHY
//
//  Created by chenguangjiang on 14-11-11.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "AddIntakerCell.h"

@implementation AddIntakerCell

- (void)awakeFromNib {
    [_backView.layer setBorderColor:kADWColor(220, 220, 220, 1).CGColor];
    [_backView.layer setBorderWidth:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)add {

    NSMutableArray *intakerArr;
    NSArray *arr = [NSArray arrayWithContentsOfFile:[self getIntakerPath]];
    if(arr != nil)
    {
        intakerArr = [[NSMutableArray alloc]initWithArray:arr];
    }
    else
    {
        intakerArr = [NSMutableArray array];
    }

    for(NSDictionary *d in intakerArr)
    {
        NSString *name = [d objectForKey:@"name"];
        if([name isEqualToString:_intakerName.text])
        {
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"该联系人已存在" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alt show];
            return;
        }
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(_intakerName.text != nil && [_intakerName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!= 0)
    {
        
        [dic setObject:_intakerName.text forKey:@"name"];
        [intakerArr addObject:dic];
        [intakerArr writeToFile:[self getIntakerPath] atomically:YES];
        [_intakerVC refreshIntakerList];
    }


  
}

-(NSString *)getIntakerPath
{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingPathComponent:@"intaker.plist"];
}
@end
