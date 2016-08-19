//
//  EditingPersonalInfoViewController.m
//  HHY
//
//  Created by jiangjun on 14-5-6.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "EditingPersonalInfoViewController.h"
#import "CustomView.h"
#import "SelectTypeButton.h"
#import "PersonModel.h"

@interface EditingPersonalInfoViewController ()
{
    NSInteger creditypeNum;
    UIView *_pickerView;
    UIDatePicker *_picker;
    UIScrollView *_scrolView;
    CustomView *view1;
}
@end

@implementation EditingPersonalInfoViewController

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
    [self initNav:@"编辑个人信息"];
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

-(void)rightClick
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (_nameTF.text)
        {
      
            [dict setValue:_nameTF.text forKey:@"staffName"];
        }

    
    if(_sexTF.typeLable.text)
    {

        [dict setValue:@"男" forKey:@"sex"];
    }
    if (_birthdayTF.typeLable.text) {
        [dict setValue:[_birthdayTF.typeLable.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]forKey:@"birthday"];
    }
    [dict setValue:[_identityNumTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]forKey:@"creditNo"];
    if(_sexTF.typeLable.text && _sexTF.typeLable.text.length != 0)
    {
        [dict setValue:[NSString stringWithFormat:@"%d",creditypeNum] forKey:@"creditType"];
    }
    [dict setValue:[_emialTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"email"];
    [dict setValue:[_phoneNumTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"mobile"];
    [dict setValue:_model.id forKey:@"id"];
    [dict setValue:[_model.password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]forKey:@"password"];


    
    if ([_nameTF.text isEqualToString:@""] || !_nameTF.text) {
        [Utils alertWithTitle:@"姓名不能为空" message:nil];
    }else if([_birthdayTF.typeLable.text isEqualToString:@""] || !_birthdayTF.typeLable.text){
        [Utils alertWithTitle:@"生日不能为空" message:nil];
    }else if([_sexTF.typeLable.text isEqualToString:@""] || !_sexTF.typeLable.text){
        [Utils alertWithTitle:@"性别不能为空" message:nil];
    }else if([_identityNumTF.text isEqualToString:@""] || !_identityNumTF.text){
        [Utils alertWithTitle:@"证件号不能为空" message:nil];
    }else if([_emialTF.text isEqualToString:@""] || !_emialTF.text){
        [Utils alertWithTitle:@"邮箱不能为空" message:nil];
    }else if([_phoneNumTF.text isEqualToString:@""] || !_phoneNumTF.text){
        [Utils alertWithTitle:@"手机号不能为空" message:nil];
    }else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        [[HHYNetworkEngine sharedInstance] updateUserInfo:dict block:^(NSError *error, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
     
            if (!error) {
         
                if(_delegate &&[_delegate respondsToSelector:@selector(refreshData)])
                {
                    [_delegate refreshData];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    } 
}

-(void)createScreen
{
    _scrolView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, kScreenHeight - 64)];
    [self.view addSubview:_scrolView];
    
     view1 = [[CustomView alloc] initWithFrame:CGRectMake(0, 30, 320, 210)];
    [_scrolView addSubview:view1];
    
    NSArray *nameArray = @[@"姓       名", @"性       别", @"出生日期", @"手机号码", @"证件类型", @"证  件 号", @"邮      箱"];
    for (int i=0; i<6; i++) {
        UIImageView *lineView = [AffUIToolBar imageviewRect:CGRectMake(20, 29+i*30, 300, 1) andimage:[UIImage imageNamed:@"xian"]];
        [view1 addSubview:lineView];
    }
    
    for (int i=0; i<7; i++) {
        UILabel *labletemp = [AffUIToolBar lableCgrectmake:CGRectMake(20, i*30, 70, 30) lableNametext:[nameArray objectAtIndex:i]];
        labletemp.font = FONT_14;
        labletemp.textColor = [JJDevice colorWithR:96 G:96 B:96 A:1];
        labletemp.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:labletemp];
    }
    
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, 200, 30)];
    _nameTF.font  =[UIFont systemFontOfSize:13];
    _nameTF.borderStyle = UITextBorderStyleNone;
    _nameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _nameTF.delegate = self;
    _nameTF.text = [_model.staffName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [view1 addSubview:_nameTF];
    
    _sexTF = [[SelectTypeButton alloc] initWithFrame:CGRectMake(100, 30, 200, 30)];
      _sexTF.typeLable.text = [_model.sex stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_sexTF addTarget:self action:@selector(selectSex) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:_sexTF];
    
    _birthdayTF = [[SelectTypeButton alloc] initWithFrame:CGRectMake(100, 60, 200, 30)];
    _birthdayTF.typeLable.text = _model.birthday;
    [_birthdayTF addTarget:self action:@selector(selectBirth) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:_birthdayTF];
    
    _phoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 90, 200, 30)];
    _phoneNumTF.font =[UIFont systemFontOfSize:13];
    _phoneNumTF.borderStyle = UITextBorderStyleNone;
    _phoneNumTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _phoneNumTF.delegate = self;
    _phoneNumTF.text = _model.mobile;
    [view1 addSubview:_phoneNumTF];
    
    _typebutton = [[SelectTypeButton alloc] initWithFrame:CGRectMake(100, 120, 200, 30)];
    [_typebutton addTarget:self action:@selector(selectType) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:_typebutton];
    _typebutton.typeLable.text = _model.creditType;
    creditypeNum = [_model.creditType integerValue];
    _identityNumTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 200, 30)];
    _identityNumTF.borderStyle = UITextBorderStyleNone;
    _identityNumTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _identityNumTF.font= [UIFont systemFontOfSize:13];
    _identityNumTF.tag = 800;
    _identityNumTF.delegate = self;
    _identityNumTF.text = _model.creditNo;
    [view1 addSubview:_identityNumTF];
    
    _emialTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 180, 200, 30)];
    _emialTF.tag = 801;
    _emialTF.font = [UIFont systemFontOfSize:13];
    _emialTF.borderStyle = UITextBorderStyleNone;
    _emialTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _emialTF.delegate = self;
    _emialTF.text = _model.email;
    [view1 addSubview:_emialTF];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)];
    _scrolView.userInteractionEnabled = YES;
    [_scrolView addGestureRecognizer:tap];
}

-(void)selectSex
{
    [self cancelPicker];
    [self canceltextField];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女",nil];
    sheet.tag = 52;
    sheet.delegate = self;
    sheet.frame = CGRectMake(80, 60, 160, 160);
    [sheet showInView:self.view];
}
-(void)selectBirth
{

    if(_pickerView == nil)
    {
        _pickerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight- 64- 200, 320, 200)];
      _picker  = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 320 ,200 )];
        [_picker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
        [_picker setDate:[NSDate date]];
        [_picker setDatePickerMode:UIDatePickerModeDate];
        _picker.maximumDate = [NSDate date];
        [_pickerView addSubview:_picker];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
        imageView.backgroundColor = kADWColor(230, 230, 230, 1);
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
    [self canceltextField];


    
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
-(void)selectType
{
      [self cancelPicker];
        [self canceltextField];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"证件类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"身份证", @"护照", @"其他",nil];
    sheet.tag = 50;
    sheet.delegate = self;
    sheet.frame = CGRectMake(80, 60, 160, 160);
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [self canceltextField];
    [self cancelPicker];
    if(actionSheet.tag == 50)
    {
        if(buttonIndex == 3)
        {
            return;
        }
        
        NSArray *nameArray = @[@"身份证", @"护照", @"其他"];
        self.typeNumber = [NSString stringWithFormat:@"%ld", (long)buttonIndex];
        self.typebutton.typeLable.text = [nameArray objectAtIndex:buttonIndex];
        creditypeNum = buttonIndex;
    }
    if(actionSheet.tag == 52)
    {
        if(buttonIndex == 2)
        {
            return;
        }
        NSArray *sexArr = @[@"男",@"女"];
        _sexTF.typeLable.text = [sexArr objectAtIndex:buttonIndex];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_nameTF resignFirstResponder];
    [_sexTF resignFirstResponder];
    [_birthdayTF resignFirstResponder];
    [_phoneNumTF resignFirstResponder];
    [_identityNumTF resignFirstResponder];
    [_emialTF resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self cancelPicker];
    if(kScreenHeight < 568)
    {
    if(textField.tag == 800)
    {
        _scrolView.contentOffset = CGPointMake(0, 80);
    }
    if(textField.tag == 801)
    {
        _scrolView.contentOffset = CGPointMake(0, 100);
    }
        _scrolView.contentSize= CGSizeMake(320, kScreenHeight);
    }
    return YES;
}
-(void)canceltextField
{
    for(UITextField *textFiled in view1.subviews)

    {
        [textFiled resignFirstResponder];
    }
}


- (NSString *)URLEncodedString:(NSString *)str{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)str,
                                                                           NULL,
                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8));
 
    return result;
}

-(void)hidden
{
    [self cancelPicker];
    [self canceltextField];
    
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
