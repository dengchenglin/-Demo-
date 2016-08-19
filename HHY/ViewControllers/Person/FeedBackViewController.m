//
//  FeedBackViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-25.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "FeedBackViewController.h"
#import "CustomView.h"

@interface FeedBackViewController ()<UITextViewDelegate>
{
    UILabel *_placlorLabel;
    CustomView *view1;
}
@end

@implementation FeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNav:@"反馈"];
    [self createScreen];
}

-(void)createScreen
{
 
   view1 = [[CustomView alloc] initWithFrame:CGRectMake(0, 30, 320, 150)];
    [self.view addSubview:view1];

    _pingjiaTV = [[UITextView alloc] initWithFrame:CGRectMake(20, 1, 300, 148)];
    _pingjiaTV.delegate = self;
    _pingjiaTV.font= [UIFont systemFontOfSize:13];
    [view1 addSubview:_pingjiaTV];
    
  _placlorLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, 0, 280, 50)];
    _placlorLabel.font = [UIFont systemFontOfSize:13];
    _placlorLabel.alpha = 0.3;
    _placlorLabel.numberOfLines = 0;
    _placlorLabel.text = @"请您在这里留下您得宝贵意见,来帮助我们给您提供更好得服务 !  (必填 五百字以内)";

    
    [_pingjiaTV addSubview:_placlorLabel];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(60, view1.frame.size.height+60, 200, 40);
    [button setTitle:@"反馈" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Feedback) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"buttonCN"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];
    
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenkeyboard)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
}

-(void)hiddenkeyboard
{
    for(UITextView *view in view1.subviews)
    {
        [view resignFirstResponder];
    }
}
- (void)Feedback
{

    if(_pingjiaTV.text && [_pingjiaTV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length != 0)
    {
        [self putMessage];
    }
    else
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"反馈信息不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
    }
}


-(void)putMessage
{
    

    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"HHY-Token"],@"token",_pingjiaTV.text,@"contant", nil];
    
    [[HHYNetworkEngine sharedInstance]feedBack:dic block:^(NSError *error, NSDictionary *data){

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            [self showAlert:@"反馈信息成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [Utils alertWithTitle:@"提交失败" message:nil];
        }
    }];


 
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    _placlorLabel.hidden = YES;
    return YES;
}
-(void)textViewDidChangeSelection:(UITextView *)textView
{
    if(textView.text == nil || textView.text.length == 0)
    {
        _placlorLabel.hidden = NO;
    }
    else
    {
        _placlorLabel.hidden = YES;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;

}


- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:nil message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}

@end
