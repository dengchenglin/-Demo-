//
//  ResignViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "ResignViewController.h"
#import "LoginViewController.h"
#import "LeftView.h"

@interface ResignViewController ()

@end

@implementation ResignViewController

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
    [self initNav:@"注册"];
    [self creatScreen];
}

-(void)creatScreen
{
    for (int i=0; i<4; i++) {
        UIImageView *lineView = [AffUIToolBar imageviewRect:CGRectMake(0, i*41+59, 320, 1) andimage:[UIImage imageNamed:@"xian"]];
        [self.view addSubview:lineView];
    }
    
    _nameTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 60, 320, 40)];
    _nameTextFiled.borderStyle = UITextBorderStyleNone;
    LeftView *nameview = [[LeftView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    nameview.lable.text = @"用  户  名: ";
    
    _nameTextFiled.leftViewMode = UITextFieldViewModeAlways;
    _nameTextFiled.leftView = nameview;
    _nameTextFiled.backgroundColor = [UIColor whiteColor];
    NSUserDefaults *current = [NSUserDefaults standardUserDefaults];
    //_nameTextFiled.text = [current objectForKey:@"userName"];
    _nameTextFiled.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:_nameTextFiled];
    _nameTextFiled.delegate = self;
    
    _passwordTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 101, 320, 40)];
    _passwordTextFiled.borderStyle = UITextBorderStyleNone;
   // _passwordTextFiled.text = [current objectForKey:@"password"];
    _passwordTextFiled.backgroundColor = [UIColor whiteColor];
    LeftView *passView = [[LeftView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    passView.lable.text = @"密       码: ";
    _passwordTextFiled.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextFiled.secureTextEntry = YES;
    _passwordTextFiled.leftView = passView;
    [self.view addSubview:_passwordTextFiled];
    _passwordTextFiled.delegate = self;
    
    _surePasswdTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 142, 320, 40)];
    _surePasswdTF.backgroundColor = [UIColor whiteColor];
    _surePasswdTF.borderStyle = UITextBorderStyleNone;
    _surePasswdTF.secureTextEntry = YES;
    LeftView *surepassView = [[LeftView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    surepassView.lable.text = @"确认密码:";
    _surePasswdTF.leftViewMode = UITextFieldViewModeAlways;
    _surePasswdTF.leftView = surepassView;
    [self.view addSubview:_surePasswdTF];
    _surePasswdTF.delegate = self;
    
    UIButton *rememberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rememberButton.frame = CGRectMake(20, 195, 21.5, 20);
    [self.view addSubview:rememberButton];
    [rememberButton addTarget:self action:@selector(agreeZunshou:) forControlEvents:UIControlEventTouchUpInside];
    [rememberButton setBackgroundImage:[UIImage imageNamed:@"rember.png"] forState:UIControlStateNormal];
    UILabel *rememberlable = [[UILabel alloc] initWithFrame:CGRectMake(45, 190, 90, 30)];
    rememberlable.text = @"我已阅读并同意";
    rememberlable.font = FONT_12;
    rememberlable.textAlignment = NSTextAlignmentRight;
    rememberlable.textColor = [UIColor grayColor];
    [self.view addSubview:rememberlable];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"《合和缘旅游用户注册协议》" forState:UIControlStateNormal];
    button.frame = CGRectMake(135, 191, 160, 30);
    [button setTitleColor:[JJDevice colorWithR:115 G:168 B:207 A:1] forState:UIControlStateNormal];
    button.titleLabel.font = FONT_12;
    [self.view addSubview:button];
    
    UIButton *resignBT = [UIButton buttonWithType:UIButtonTypeCustom];
    resignBT.frame = CGRectMake(60, 240, 200, 40);
    [self.view addSubview:resignBT];
    [resignBT setBackgroundImage:[UIImage imageNamed:@"resign.png"] forState:UIControlStateNormal];
    resignBT.layer.cornerRadius = 5;
    resignBT.layer.masksToBounds = YES;
    [resignBT addTarget:self action:@selector(resign) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resgiterKboard)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
}

-(void)agreeZunshou:(UIButton *)button
{
    if (isAgree) {
        [button setBackgroundImage:[UIImage imageNamed:@"notrember.png"] forState:UIControlStateNormal];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"rember.png"] forState:UIControlStateNormal];
    }
    isAgree = !isAgree;
}

-(void)resign
{
    [_nameTextFiled resignFirstResponder];
    [_passwordTextFiled resignFirstResponder];
    [_surePasswdTF resignFirstResponder];
    if (self.nameTextFiled.text == nil || [self.nameTextFiled.text isEqualToString:@""]) {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
    }else if(self.passwordTextFiled.text == nil || [self.passwordTextFiled.text isEqualToString:@""]){
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
    }else if(![self.passwordTextFiled.text isEqualToString:self.surePasswdTF.text]){
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码不一样" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:self.nameTextFiled.text forKey:@"userName"];
        [dict setValue:self.passwordTextFiled.text forKey:@"password"];
        [[HHYNetworkEngine sharedInstance] registerUser:dict block:^(NSError *error, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!error) {
                NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
                [userdf setObject:self.nameTextFiled.text forKey:@"userName"];
                [userdf setObject:self.passwordTextFiled.text forKey:@"password"];
                [userdf setObject:data forKey:@"token"];

                _loginVC.nameTextFiled.text = self.nameTextFiled.text;
                _loginVC.passwordTextFiled.text = self.passwordTextFiled.text;
       
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                if(data)
                {
                     [Utils alertWithTitle:(NSString *)data message:nil];
                }
               
             
            }
          
        }];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameTextFiled resignFirstResponder];
    [self.passwordTextFiled resignFirstResponder];
    [self.surePasswdTF resignFirstResponder];
    return YES;
}
-(void)resgiterKboard
{
    for(UITextField *textfield in self.view.subviews)
    {
        [textfield resignFirstResponder];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
