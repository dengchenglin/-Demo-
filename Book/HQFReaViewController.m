//
//  HQFReaViewController.m
//  IOS
//
//  Created by qianfeng on 13-11-20.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFReaViewController.h"
#import "ASIHTTPRequest.h"
#import "GDataXMLNode.h"
#import <QuartzCore/QuartzCore.h>

@interface HQFReaViewController ()

@property(nonatomic,retain) NSString *contentStr;
@property (nonatomic,assign) NSInteger myFontSize;
@property(nonatomic, assign) int currentPage;
@property(nonatomic, assign) int allPage;
@property (nonatomic,assign) BOOL flag;

@property (nonatomic,retain) UIView *fontView;
@property (nonatomic,retain) UISlider *fontSlider;

@property(nonatomic, retain) UIView * brightView;
@property(nonatomic, retain) UISlider * brightSlider
;
@property(nonatomic, retain) UIView * adjustBrightView;
@property (nonatomic,assign) CGFloat bright;

@property(nonatomic, retain) UIView * backGroundView;
@property (nonatomic,retain) UIColor * color;
@property (nonatomic,retain) UIColor * whiteColor;
@property (nonatomic,retain) UIColor * blackColor;
@property (nonatomic,assign) NSInteger clickNum;

- (void)initTextView;
@end

@implementation HQFReaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _myFontSize = 15;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _whiteColor = [UIColor whiteColor];
    _blackColor = [UIColor blackColor];
    _color = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myTap:)];
    [_myLabelView addGestureRecognizer:tap];
    
    self.fontView = [[UIView alloc] initWithFrame:CGRectMake(0, 460 + 20, 320, 50)];
    self.fontView.alpha = 0.9;
    self.fontView.backgroundColor = [UIColor blackColor];
    self.fontSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, 20, 240, 15)];

    self.fontSlider.highlighted = YES;
    self.fontSlider.maximumValue = 30;
    self.fontSlider.minimumValue = 15;
    self.fontSlider.thumbTintColor = [UIColor brownColor];
    self.fontSlider.minimumTrackTintColor= [UIColor brownColor];
    self.fontSlider.continuous = NO;
    [self.fontSlider addTarget:self action:@selector(changeFontSize:) forControlEvents:UIControlEventValueChanged];
    UIImageView * imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 40, 45)];
    [imgView1 setImage:[UIImage imageNamed:@"font_desc.png"]];
    UIImageView * imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(280, 10, 40, 45)];
    [imgView2 setImage:[UIImage imageNamed:@"font_asc.png"]];
    [self.fontView addSubview:imgView1];
    [self.fontView addSubview:imgView2];
    [self.fontView addSubview:self.fontSlider];
    [self.view addSubview:self.fontView];
    
//*************************************************
    _adjustBrightView = [[UIView alloc] initWithFrame:CGRectMake(0, 460 + 20, 320, 50)];
    _adjustBrightView.alpha = 0.9;
    _adjustBrightView.backgroundColor = [UIColor blackColor];
    
    _brightSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, 20, 240, 15)];
    [_brightSlider setHighlighted:YES];
    _brightSlider.maximumValue = 0.6;
    _brightSlider.minimumValue = 0;
    [_brightSlider setThumbTintColor:[UIColor whiteColor]];
    [_brightSlider setMinimumTrackTintColor:[UIColor greenColor]];
    [_brightSlider setContinuous:NO];
    [_brightSlider addTarget:self action:@selector(changeBrightness:) forControlEvents:UIControlEventValueChanged];
    
    UIImageView * imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 40, 40)];
    [imgView3 setImage:[UIImage imageNamed:@"light_asc.png"]];
    
    UIImageView * imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(280, 10, 40, 40)];
    [imgView4 setImage:[UIImage imageNamed:@"light_desc.png"]];
    [_adjustBrightView addSubview:imgView3];
    [_adjustBrightView addSubview:imgView4];
    
    [_adjustBrightView addSubview:_brightSlider];
    [self.view addSubview:_adjustBrightView];
    
//  ********************************************************************
    _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 460 + 20, 320, 40)];
    _backGroundView.alpha = 0.9;
    _backGroundView.backgroundColor = [UIColor whiteColor];
    [_backGroundView setTag:300];
    NSArray * imgNames = @[@"bg1.png",@"bg2.png",@"bg3.png"];
    
    for(int i = 0; i < 3; i++){
        UIButton * imgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [imgButton setFrame:CGRectMake(20+100 * i, 10, 80, 30)];
        [imgButton setBackgroundImage:[UIImage imageNamed:[imgNames objectAtIndex:i]] forState:UIControlStateNormal];
        [imgButton setTag:200 + i];
        [imgButton addTarget:self action:@selector(backgroundChange:) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundView addSubview:imgButton];
    }
    
    [self.view addSubview:_backGroundView];
    
}

- (void)myTap:(UITapGestureRecognizer *)tap
{
    if (_flag==YES) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.upMyView.alpha = 0.7;
        self.downMyView.alpha = 0.7;
        
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.upMyView.alpha = 0;
        self.downMyView.alpha = 0;
        [_fontView setFrame:CGRectMake(0, 460, 320, 50)];
        [_adjustBrightView setFrame:CGRectMake(0, 460, 320, 50)];
        [_backGroundView setFrame:CGRectMake(0, 460, 320, 50)];
        [UIView commitAnimations];

    }
    _flag = !_flag;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)setTabOnBtn:(UIButton *)sender {
    NSLog(@"--------------");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [_backGroundView setFrame:CGRectMake(0, 460-47 -50, 320, 50)];
    [UIView commitAnimations];
}



- (IBAction)setTabOnBtn1:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [_adjustBrightView setFrame:CGRectMake(0, 460-47 -50, 320, 50)];
    [UIView commitAnimations];
}

- (IBAction)setTabOnBtn2:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    //[self.downMyView setFrame:CGRectMake(0, 460 + 20, 320, 50)];
    [_fontView setFrame:CGRectMake(0, 460-47-50, 320, 50)];
    [UIView commitAnimations];
    
}

#pragma mark- 改变背景
- (void)backgroundChange:(UIButton *)sender
{
    
    _color = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"bg%d.png", sender.tag - 200+1]]];
    [_readTextView setBackgroundColor:_color];
    if(sender.tag - 200 == 0){
        _clickNum = 200;
        _readTextView.textColor = _whiteColor;
    }
    else{
        _clickNum = 400;
        _readTextView.textColor = _blackColor;
    }
}

#pragma mark- 改变亮度
- (void)changeBrightness:(UISlider *)slider
{
     _bright = slider.value;
    _brightView.alpha = _bright;
    
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sliderHidden) userInfo:nil repeats:NO];
}

#pragma mark -改变字体大小
-(void)changeFontSize:(UISlider *)slider
{
    _myFontSize = _fontSlider.value;
    NSLog(@"------%d",_myFontSize);
    _readTextView.font = [UIFont systemFontOfSize:_myFontSize];
}
#pragma mark --
#pragma mark 实力化TextView

- (void)initTextView
{
    
    _readTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320,460)];
    _readTextView.editable = NO;
    _readTextView.font = [UIFont systemFontOfSize:self.myFontSize];
    size = [self.contentStr sizeWithFont:[UIFont systemFontOfSize:self.myFontSize] constrainedToSize:CGSizeMake(300, 20000)];
    //_readTextView.textColor = _blackColor;
    NSLog(@"=====%f",size.height);
    _readTextView.showsVerticalScrollIndicator = NO;
    _readTextView.delegate = self;
    _readTextView.scrollEnabled = NO;
    _readTextView.editable = NO;
    _readTextView.userInteractionEnabled = YES;
    _readTextView.backgroundColor = _color;
    _readTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    if (_clickNum == 200) {
        _readTextView.textColor = _whiteColor;
    }
    else if(_clickNum == 400)
    {
        _readTextView.textColor = _blackColor;
    }
    _readTextView.text = self.contentStr;
    self.allPage = size.height/460 + 1;
    NSLog(@"------%f",size.height/460);
    self.currentPage = 1;
    
    [self swipAllDirection:_readTextView];
    [self.myLabelView addSubview:_readTextView];
}

#pragma mark - 利用手势来模拟翻页效果
-(void)swipAllDirection:(UIView*)view
{
    UISwipeGestureRecognizer *swipUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upPage)];
    swipUp.view.tag = 150;
    [swipUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [view addGestureRecognizer:swipUp];
    [_brightView addGestureRecognizer:swipUp];
    [_readTextView addGestureRecognizer:swipUp];
    
    UISwipeGestureRecognizer *swipDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(downPage)];
    
    [swipDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [view addGestureRecognizer:swipDown];
    [_brightView addGestureRecognizer:swipDown];
    [_readTextView addGestureRecognizer:swipDown];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upPage)];
    [swipRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [view addGestureRecognizer:swipRight];
    [_brightView addGestureRecognizer:swipRight];
    [_readTextView addGestureRecognizer:swipRight];
    
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(downPage)];
    [swipLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [view addGestureRecognizer:swipLeft];
    [_brightView addGestureRecognizer:swipLeft];
    [_readTextView addGestureRecognizer:swipLeft];
    
}

#pragma mark - 翻页动作
-(void)upPage
{
    

    if(self.currentPage == 1)
    {
        
        if (self.myUpChapter==0||self.myUpChapter<self.myChaterFirst) {
            NSLog(@"----------------%d",self.myUpChapter);
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"第一页" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            
            return;
        }
        //返回上一章
        NSLog(@"upPage>>>selfChapter=%d",self.myUpChapter);
        self.myNextChapter = self.myUpChapter;
        NSLog(@"upPage>>>NextChapter=%d",self.myNextChapter+1);
        [self requestUpURL:self.myUpChapter];
        
        self.myUpChapter = self.myUpChapter - 1;
        self.currentPage = 5;
    }

    self.currentPage = self.currentPage-1;
    NSLog(@"-------%d",self.currentPage);
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageUnCurl";
    animation.subtype = kCATransitionFromRight;;
    [self.view.layer addAnimation:animation forKey:nil];
    [_readTextView setContentOffset:CGPointMake(0, (self.currentPage-1)*460)];
    NSLog(@"=======%d",(self.currentPage-1)*460);
    
    
}

-(void)downPage
{
    if(self.currentPage>size.height/460)
    {
        _flag = YES;
        //加载下一章
        self.myNextChapter = self.myNextChapter +1;
        [self requestBookURL:self.myNextChapter];
        self.myUpChapter = self.myNextChapter-1;
        NSLog(@"downPage>>>self>Chapter==%d",self.myNextChapter);
        NSLog(@"downPage>>>UpChapter==%d",self.myUpChapter);
        [_readTextView setContentOffset:CGPointMake(0, 0*460)];
//        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"最后一页" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//        return;
    }
    self.currentPage = self.currentPage+1;
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.subtype = kCATransitionFromRight;
    [self.view.layer addAnimation:animation forKey:nil];
    [_readTextView setContentOffset:CGPointMake(0, (self.currentPage-1)*460)];
}


#pragma mark --
#pragma mark HQFReadProtocol代理


- (void)readBookId:(NSString *)bookId AndChapterFirstId:(NSString *)chapterFirstId
{
    self.myBookId = bookId;
    self.myNextChapter = [chapterFirstId intValue];
    self.myChaterFirst = [chapterFirstId intValue];
    //self.myUpChapter = self.myChaterFirst;
    [self requestBookURL:[chapterFirstId intValue]];
    
    
}

- (void)bookId:(NSString *)bookId AndChapterId:(NSInteger)chapterId
{
    NSString *strURL = [NSString stringWithFormat:@"http://c4.shuqireader.com/httpserver/filecache/get_book_content_%@_%d_1379952000_1_0.xml",bookId,chapterId];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[strURL stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    request.delegate = self;
    [request startAsynchronous];
}
- (void)requestBookURL:(NSInteger)chapterId
{
    NSString *strURL = [NSString stringWithFormat:@"http://c4.shuqireader.com/httpserver/filecache/get_book_content_%@_%d_1379952000_1_0.xml",self.myBookId,chapterId];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[strURL stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    request.delegate = self;
    [request startAsynchronous];
}

- (void)requestUpURL:(NSInteger)chapterId
{
    NSString *strURL = [NSString stringWithFormat:@"http://c4.shuqireader.com/httpserver/filecache/get_book_content_%@_%d_1379952000_1_0.xml",self.myBookId,chapterId];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[strURL stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    request.delegate = self;
    request.tag = 105;
    [request startAsynchronous];
}

- (void)muLuChapterId:(NSInteger)chapterId AndChapterFirst:(NSInteger)chapterFirst AndBookId:(NSString *)readBookId
{
    self.myNextChapter = chapterId;
    NSLog(@"self>>>>Chapter===%d",self.myNextChapter);
    self.myChaterFirst = chapterFirst;
    if (chapterId == chapterFirst) {
        self.myUpChapter = 1;
    }
    self.myUpChapter = chapterId-1;
    self.myBookId = readBookId;
    [self muLuRequestChapter:chapterId];
}

- (void)muLuRequestChapter:(NSInteger)chapter
{
    NSString *strURL = [NSString stringWithFormat:@"http://c4.shuqireader.com/httpserver/filecache/get_book_content_%@_%d_1379952000_1_0.xml",self.myBookId,chapter];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    request.delegate = self;
    request.tag = 20;
    [request startAsynchronous];
}

#pragma mark --
#pragma mark ASIHTTPRequestDelegate的代理
int count = 0;
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    [_brightView removeFromSuperview];
    if (request.tag == 105) {
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:[request responseData] options:0 error:nil];
        NSArray *nodeArr = [doc nodesForXPath:@"/ChapterContent" error:nil];
        GDataXMLElement *element = [nodeArr lastObject];
        
        self.contentStr = [element stringValue];
        [self initTextView];
        [_readTextView scrollRectToVisible:CGRectMake(0,size.height - 400, 320, 460) animated:NO];
        self.currentPage = self.allPage;
    }
    else
    {
        NSString *xml = nil;
        static NSInteger x = -2147482062;
        
        do {
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(CFStringConvertEncodingToNSStringEncoding(x++));
            
            xml = [[NSString alloc] initWithData:[request responseData] encoding:enc];
        } while (xml == nil);
        
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:nil];
        NSArray *nodeArr = [doc nodesForXPath:@"/ChapterContent" error:nil];
        GDataXMLElement *element = [nodeArr lastObject];
        
        self.contentStr = [element stringValue];
        [self initTextView];
    }
    
    
    _brightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10000)];
    _brightView.alpha = _bright;
    
    _brightView.userInteractionEnabled = YES;
    _brightView.backgroundColor = [UIColor blackColor];
    [_readTextView addSubview:_brightView];
    
    
}

@end
