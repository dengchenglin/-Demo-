//
//  PersonalInformationViewController.m
//  HHY
//
//  Created by jiangjun on 14-5-6.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "CustomView.h"
#import "UserModel.h"
#import "EditingPersonalInfoViewController.h"
#import "PersonModel.h"

@interface PersonalInformationViewController ()<EditingPersonDelegate>

@end

@implementation PersonalInformationViewController

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
    [self initNav:@"个人信息"];
    [self createScreen];
    [self createData];
}

-(void)createData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] queryOneUser:^(NSError *error, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            self.model = data;
            [self refreshText];
        }
    }];
}

-(void)createScreen
{
    UILabel *lable = [AffUIToolBar lableCgrectmake:CGRectMake(20, 0, 50, 45) lableNametext:@"用户名:"];
    lable.font = FONT_14;
    lable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lable];
    _usernameLable = [AffUIToolBar lableCgrectmake:CGRectMake(70, 0, 200, 45) lableNametext:_model.userName];
    _usernameLable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_usernameLable];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 45, 320, 30)];
    view.backgroundColor = [JJDevice colorWithR:223 G:223 B:223 A:1];
    [self.view addSubview:view];
    
    UILabel *plable = [AffUIToolBar lableCgrectmake:CGRectMake(25, 45, 60, 30) lableNametext:@"个人资料"];
    plable.font = FONT_15;
    plable.textColor = [JJDevice colorWithR:87 G:87 B:87 A:1];
    plable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:plable];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(260, 45, 40, 30);
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitleColor:[JJDevice colorWithR:219 G:131 B:51 A:1] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(btnEdit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    CustomView *view1 = [[CustomView alloc] initWithFrame:CGRectMake(0, 90, 320, 210)];
    [self.view addSubview:view1];
    
    NSArray *nameArray = @[@"姓       名", @"性       别", @"出生日期", @"手机号码", @"证件类型", @"证  件 号", @"邮      箱"];
    for (int i=0; i<6; i++) {
        UIImageView *lineView = [AffUIToolBar imageviewRect:CGRectMake(20, 29+i*30, 300, 1) andimage:[UIImage imageNamed:@"xian"]];
        [view1 addSubview:lineView];
    }
    
    for (int i=0; i<7; i++) {
        UILabel *labletemp = [AffUIToolBar lableCgrectmake:CGRectMake(20, i*30, 70, 30) lableNametext:[nameArray objectAtIndex:i]];
        labletemp.font = FONT_14;
        labletemp.textColor = [JJDevice colorWithR:96 G:96 B:96 A:1];
        labletemp.textAlignment = NSTextAlignmentLeft;
        [view1 addSubview:labletemp];
    }
    
    _nameTF = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 30)];
    _nameTF.font =[UIFont systemFontOfSize:14];

    [view1 addSubview:_nameTF];
    
    _sexTF = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 200, 30)];

    _sexTF.font =[UIFont systemFontOfSize:14];
    [view1 addSubview:_sexTF];
    
    _birthdayTF = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 200, 30)];

    _birthdayTF.font =[UIFont systemFontOfSize:14];
    [view1 addSubview:_birthdayTF];
    
    _phoneNumTF = [[UILabel alloc] initWithFrame:CGRectMake(100, 90, 200, 30)];

    _phoneNumTF.font =[UIFont systemFontOfSize:14];
    [view1 addSubview:_phoneNumTF];
    
    _typeLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 120, 200, 30)];
  
    _typeLable.font =[UIFont systemFontOfSize:14];
   
    [view1 addSubview:_typeLable];
    
    _identityNumTF = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 200, 30)];
    _identityNumTF.font =[UIFont systemFontOfSize:14];

    [view1 addSubview:_identityNumTF];
    
    _emialLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 180, 200, 30)];
    _emialLable.font =[UIFont systemFontOfSize:14];
    [view1 addSubview:_emialLable];

    
    UIButton *returnLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnLoginButton setTitle:@"退出登录" forState:UIControlStateNormal];
    returnLoginButton.frame = CGRectMake(60, 340, 200, 40);
    [returnLoginButton setBackgroundImage:[UIImage imageNamed:@"gaiqi"] forState:UIControlStateNormal];
    [returnLoginButton setBackgroundImage:[UIImage imageNamed:@"gaiqiBTN"] forState:UIControlStateHighlighted];
    [returnLoginButton addTarget:self action:@selector(logExit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnLoginButton];
}
-(void)refreshText
{
 
        _nameTF.text = [_model.staffName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _sexTF.text = [_model.sex stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _birthdayTF.text = _model.birthday;
        _phoneNumTF.text = _model.mobile;
      _typeLable.text = _model.creditType;
        _identityNumTF.text = _model.creditNo;
        _emialLable.text = _model.email;
    _usernameLable.text = _model.userName;
}

-(void)logExit
{
    [[HHYNetworkEngine sharedInstance] logOut:^(NSError *error, id data) {
        if (!error) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}

-(void)btnEdit:(UIButton *)button
{
    EditingPersonalInfoViewController *vc = [[EditingPersonalInfoViewController alloc] init];
    vc.token = [[HHYNetworkEngine sharedInstance] getToken];
    vc.model = self.model;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshData{
    [self createData];
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
