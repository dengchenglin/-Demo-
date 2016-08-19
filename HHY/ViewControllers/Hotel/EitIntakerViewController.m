//
//  EitIntakerViewController.m
//  HHY
//
//  Created by chenguangjiang on 14-11-12.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "EitIntakerViewController.h"
#import "CustomNavBar.h"
@interface EitIntakerViewController ()<CustomBarDelegate>

@end

@implementation EitIntakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self initIntakerText];
}

-(void)setIntakerDic:(NSDictionary *)intakerDic
{
    if(_intakerDic != intakerDic)
    {
        _intakerDic = [intakerDic copy];
    }
}
-(void)initIntakerText
{
    NSString *name =  [_intakerDic objectForKey:@"name"];
    NSString *phoneNum = [_intakerDic objectForKey:@"phoneNum"];
    
    if(name)
    {
        self.intakerName.text = [name copy];
        
    }
    if(phoneNum)
    {
        self.phoneNum.text = phoneNum;
    }
}
-(void)createView
{

    [self initNav:@"编辑入住人"];
    
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(232, 0, 40, 44);
    [phoneButton setTitle:@"完成" forState:UIControlStateNormal];
    [phoneButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *tempItem = [[UIBarButtonItem alloc] initWithCustomView:phoneButton];
    self.navigationItem.rightBarButtonItems = @[tempItem];

}
-(void)rightButtonClick
{
    NSArray *arr = [NSArray arrayWithContentsOfFile:[self getIntakerPath]];
    NSMutableArray *intakerArr;
    if(arr != nil)
    {
        intakerArr = [NSMutableArray arrayWithArray:arr];
    }
    else
    {
        intakerArr =[NSMutableArray array];
    }
    NSMutableDictionary *intakerDic = [NSMutableDictionary dictionary];
    if(_intakerName.text != nil  && _intakerName.text.length != 0)
    {
        [intakerDic setObject:_intakerName.text forKey:@"name"];
    }
    if(_phoneNum.text != nil && _phoneNum.text.length != 0)
    {
        [intakerDic setObject:_phoneNum.text forKey:@"phoneNum"];
    }
    if(intakerDic.count != 0)
    {
        [intakerArr replaceObjectAtIndex:_index withObject:intakerDic];
        [intakerArr writeToFile:[self getIntakerPath] atomically:YES];
        [_intakerVC refreshIntakerList];
    }

    [self.navigationController popViewControllerAnimated:NO];

}

-(NSString *)getIntakerPath
{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingPathComponent:@"intaker.plist"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
