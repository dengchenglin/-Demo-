//
//  AddPersonAirPlainViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-25.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "AddPersonAirPlainViewController.h"
#import "CustomView.h"
#import "SelectTypeButton.h"
#import "Passenger.h"
#import "SelectTypeButton.h"

@interface AddPersonAirPlainViewController ()
{
    UIView *_pickerView;
    UIDatePicker *_picker;
    UIScrollView *_scrolView;
    CustomView *view1;
}

@end

@implementation AddPersonAirPlainViewController

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
    [self initNav:self.headTitle];
    NSLog(@"%d", self.editingEnable);
    [self createScreen];
}

-(void)createRighteItem
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(260, 0, 60, 44);
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *flexright = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    [flexright setWidth:isIOS7 ? -16 : -5];
    self.navigationItem.rightBarButtonItems = @[flexright, rightItem];
    
    
}

-(void)createScreen
{
    NSArray *nameArray = @[@"姓          名", @"乘机人类型", @"证 件 类 型", @"证 件 号 码", @"出 生 日 期", @"性          别", @"手          机",@"邮          箱"];
    
    _scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, kScreenHeight - 64)];
    _scrolView.showsVerticalScrollIndicator = NO;
 view1 = [[CustomView alloc] initWithFrame:CGRectMake(0, 20, 320, 240)];

    [_scrolView addSubview:view1];
    
  
    [self.view addSubview:_scrolView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenView)];
    _scrolView.userInteractionEnabled = YES;
    [_scrolView addGestureRecognizer:tap];
    
    for (int i=0; i<8; i++) {
        if (i!=0) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, i*29, 280, 1)];
            imageView.image = [UIImage imageNamed:@"xian"];
            [view1 addSubview:imageView];
        }
        UILabel *textLable = [AffUIToolBar lableCgrectmake:CGRectMake(40, i*30, 80, 30) lableNametext:[nameArray objectAtIndex:i]];
        textLable.font = [UIFont systemFontOfSize:12];
        textLable.textAlignment = NSTextAlignmentLeft;
        [view1 addSubview:textLable];
    }
    
    _personTypeButton = [[SelectTypeButton alloc]  initWithFrame:CGRectMake(130, 30, 180, 30)];
    [_personTypeButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _personTypeButton.tag = 100;
    [view1 addSubview:_personTypeButton];
    
    _certTypeButton = [[SelectTypeButton alloc] initWithFrame:CGRectMake(130, 60, 180, 30)];
    [_certTypeButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _certTypeButton.tag = 101;
    [view1 addSubview:_certTypeButton];
    
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 30)];
    _nameTF.borderStyle = UITextBorderStyleNone;


    _nameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _nameTF.font = [UIFont systemFontOfSize:13];
    [view1 addSubview:_nameTF];
    _nameTF.delegate = self;
    
    _certNumTF = [[UITextField alloc] initWithFrame:CGRectMake(130, 90, 180, 30)];
    _certNumTF.font = [UIFont systemFontOfSize:13];
    _certNumTF.borderStyle = UITextBorderStyleNone;

    [view1 addSubview:_certNumTF];
    _certNumTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _certNumTF.delegate = self;
    
    _birthdayTF = [[SelectTypeButton alloc] initWithFrame:CGRectMake(130, 120, 180, 30)];
//    _birthdayTF.typeLable.text = _model.birthday;
    [_birthdayTF addTarget:self action:@selector(selectBirth) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:_birthdayTF];
    
    _sexTF = [[SelectTypeButton alloc] initWithFrame:CGRectMake(130, 150, 180, 30)];
    _sexTF.tag = 300;
    [_sexTF addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:_sexTF];
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(130, 180, 180, 30)];
    _phoneTF.font =[UIFont systemFontOfSize:13];
    _phoneTF.borderStyle = UITextBorderStyleNone;
 
    [view1 addSubview:_phoneTF];
    _phoneTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _phoneTF.delegate = self;
    _phoneTF.tag = 100;
    _emailTF = [[UITextField alloc] initWithFrame:CGRectMake(130, 210, 180, 30)];
    _emailTF.borderStyle = UITextBorderStyleNone;
    _emailTF.font = [UIFont systemFontOfSize:13];
    [view1 addSubview:_emailTF];
    _emailTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _emailTF.delegate = self;
    _emailTF.tag = 101;
    if (self.editingEnable) {
        self.nameTF.text = _userModel.name;
        self.certNumTF.text = _userModel.zjh;
        self.birthdayTF.typeLable.text = _userModel.birthday;
        self.phoneTF.text = _userModel.mobile;
        _emailTF.text = _userModel.email;
        if ([_userModel.note isEqualToString:@"CHILD"]) {
            self.personTypeButton.typeLable.text = @"儿童";
            self.passegerType = @"1";
        }else{
            self.personTypeButton.typeLable.text = @"成人";
            self.passegerType = @"0";
        
        }
 
        NSArray *certArray = @[@"身份证", @"护照", @"其他",@"军官证",@"回乡证",@"港澳通行证",@"台胞证"];
        if(_userModel.zjlx != nil && _userModel.zjlx.length != 0)
        {
            self.certTypeButton.typeLable.text =[certArray objectAtIndex:_userModel.zjlx.integerValue];
     
            self.certType = _userModel.zjlx;
        }
  

        if(_userModel.sex != nil && _userModel.sex.length != 0)
        {
            self.sexTF.typeLable.text = _userModel.sex;
        }
    }
    
  
    
}

-(void)btnClick:(SelectTypeButton *)button
{
    [_nameTF becomeFirstResponder];
    [_nameTF resignFirstResponder];
    
    if (button.tag == 100) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"乘机人类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"成人", @"儿童", nil];
        sheet.tag = 200;
        [sheet showInView:self.view];
    } else if(button.tag==300){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
        sheet.tag = 202;
        [sheet showInView:self.view];
    } else {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"乘机人类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"身份证", @"护照", @"其他",@"军官证",@"回乡证",@"港澳通行证",@"台胞证", nil];
        sheet.tag = 201;
        [sheet showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 200) {
        if(buttonIndex == 2)
        {
            return;
        }
        NSArray *array = @[@"成人", @"儿童"];
        NSArray *typePasserger = @[@"ADULT", @"CHILD"];
        _personTypeButton.typeLable.text = [array objectAtIndex:buttonIndex];
        self.passegerType = [typePasserger objectAtIndex:buttonIndex];
    } else if (actionSheet.tag==202) {
        if(buttonIndex == 2)
        {
            return;
        }
        NSArray *array = @[@"男",@"女"];
        _sexTF.typeLable.text  = [array objectAtIndex:buttonIndex];
    } else{
        if(buttonIndex == 7)
        {
            return;
        }
        NSArray *array = @[@"身份证", @"护照", @"其他",@"军官证",@"回乡证",@"港澳通行证",@"台胞证"];
        NSArray *certTypeArray = @[@"0", @"1", @"2",@"3",@"4",@"5",@"6"];
        _certTypeButton.typeLable.text = [array objectAtIndex:buttonIndex];
        self.certType = [certTypeArray objectAtIndex:buttonIndex];
    }
}

-(void)rightClick
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    

    if ([_nameTF.text length]==0) {
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入乘机人姓名!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        
        return ;
    }
    
    if ([self.passegerType length]==0) {
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择乘机人类型!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        
        return ;
    }
    

    if ([self.certType length]==0) {
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择证件类型!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        
        return ;
    }
    
    if ([self.certNumTF.text length]==0) {
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入证件号码!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        
        return ;
    }
    
    if([_birthdayTF.typeLable.text length]==0) {
            UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择出生日期!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [altView show];
            
            return ;
    }
    
    if ([_sexTF.typeLable.text length]==0) {
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择性别!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        
        return ;
    }
    
    if ([_phoneTF.text length]==0) {
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入电话号码!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        
        return ;
    }
    
    if (self.editingEnable) {
        [dict setValue:_nameTF.text forKey:@"name"];
        [dict setValue:_userModel.ID forKey:@"id"];
        [dict setValue:_birthdayTF.typeLable.text forKey:@"birthday"];
        [dict setValue:_emailTF.text forKey:@"email"];
        [dict setValue:self.certType forKey:@"zjlx"];
        [dict setValue:self.passegerType forKey:@"note"];
        [dict setValue:_phoneTF.text forKey:@"mobile"];
        [dict setValue:_certNumTF.text forKey:@"zjh"];
        [dict setValue:_sexTF.typeLable.text forKey:@"sex"];
    }else{
        [dict setValue:_nameTF.text forKey:@"name"];
        [dict setValue:_birthdayTF.typeLable.text forKey:@"birthday"];
        [dict setValue:_emailTF.text forKey:@"email"];
        [dict setValue:self.certType forKey:@"zjlx"];
        [dict setValue:self.passegerType forKey:@"note"];
        [dict setValue:_phoneTF.text forKey:@"mobile"];
        [dict setValue:_certNumTF.text forKey:@"zjh"];
        [dict setValue:_sexTF.typeLable.text forKey:@"sex"];
    }
 
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.editingEnable) {
        [[HHYNetworkEngine sharedInstance] updatePassenger:dict block:^(NSError *error, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!error) {
                if(_delegate && [_delegate respondsToSelector:@selector(refreshAirPerson)])
                {
                    [_delegate refreshAirPerson];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }else{
        [[HHYNetworkEngine sharedInstance] addPassenger:dict block:^(NSError *error, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(_delegate && [_delegate respondsToSelector:@selector(refreshAirPerson)])
            {
                [_delegate refreshAirPerson];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

-(void)deletePerson
{
    
}

-(void)choseNum:(UIButton *)button
{
    
}

- (void)sexChoose
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [_nameTF resignFirstResponder];
    [_certNumTF resignFirstResponder];
    [_birthdayTF resignFirstResponder];
    [_phoneTF resignFirstResponder];
    [_emailTF resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(kScreenHeight < 568)
    {
            _scrolView.contentSize = CGSizeMake(320, kScreenHeight);
        if(textField.tag == 100)
        {
            _scrolView.contentOffset = CGPointMake(0, 70);
        }
        if(textField.tag == 101)
        {
            _scrolView.contentOffset = CGPointMake(0, 100);
        }
   
    }
    [self cancelPicker];
    
    return YES;
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

-(void)selectBirth
{
    
    if(_pickerView == nil)
    {
        _pickerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight- 64- 200, 320, 200)];
        _picker  = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 320 ,200 )];
        [_picker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        
        [_picker setDate:[NSDate date]];
        [_picker setDatePickerMode:UIDatePickerModeDate];
        [_pickerView addSubview:_picker];
        _picker.maximumDate = [NSDate date];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
        imageView.backgroundColor = kADWColor(210, 210, 210, 1);
        [_pickerView addSubview:imageView];
        UIButton *cancelBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBut setFrame:CGRectMake(10, 5, 50, 30)];
        [cancelBut setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [cancelBut addTarget:self action:@selector(cancelPicker) forControlEvents:UIControlEventTouchUpInside];
        [_pickerView addSubview:cancelBut];
        UIButton *sureBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBut setTitle:@"确定" forState:UIControlStateNormal];
        [sureBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [sureBut setFrame:CGRectMake(260, 5, 50, 30)];
        [sureBut addTarget:self action:@selector(surePicker) forControlEvents:UIControlEventTouchUpInside];
        [_pickerView addSubview:sureBut];
        _pickerView.backgroundColor= kADWColor(240, 240, 240, 1);
        [self.view addSubview:_pickerView];
    }
    _pickerView.hidden = NO;
    [self hiddenView];
    
    
}
-(void)cancelPicker
{
    _pickerView.hidden = YES;
}
-(void)surePicker
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    _birthdayTF.typeLable.text = [formatter stringFromDate:_picker.date];
    _pickerView.hidden = YES;
    
}
-(void)hiddenView
{
    for(UITextField *textField in view1.subviews)
    {
        [textField resignFirstResponder];
    }


}

@end
