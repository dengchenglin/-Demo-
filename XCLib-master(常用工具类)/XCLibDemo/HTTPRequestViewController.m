//
//  ViewController.m
//  XCLibDemo
//
//  Created by qianbailangmac on 15/12/21.
//  Copyright © 2015年 XC. All rights reserved.
//

#import "HTTPRequestViewController.h"
#import "XCLib.h"

@interface HTTPRequestViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)downloadAction:(id)sender;
- (IBAction)uploadAction:(id)sender;
- (IBAction)postAction:(id)sender;
- (IBAction)getAction:(id)sender;
@end

@implementation HTTPRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressView.progress = 0;
    [XCHTTPClient sharedInstance].responseSerializer = [[XCJSONResponseSerializer alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidStart) name:XCHTTPClientTaskDidStartNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidFinish) name:XCHTTPClientTaskDidFinishNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)taskDidStart
{
    self.textView.text = nil;
    self.progressView.progress = 0;
    if ([self.indicatorView isAnimating]) {
        [self.indicatorView stopAnimating];
    }
    [self.indicatorView startAnimating];
}

- (void)taskDidFinish
{
    [self.indicatorView stopAnimating];
}

- (IBAction)downloadAction:(id)sender
{
    [[XCHTTPClient sharedInstance] downloadWithURL:[NSURL URLWithString:@"http://xiazai.xiazaiba.com/Soft/P/pidownload_6.3.6.4_XiaZaiBa.zip"] parameter:nil progress:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        self.progressView.progress = (float)totalBytesSent / totalBytesExpectedToSend;
    } completion:^(NSURL *location, NSURLResponse *response) {
        self.textView.text = [location description];
    } failure:^(NSError *error) {
        self.textView.text = [error description];
    }];
}

- (IBAction)uploadAction:(id)sender
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image.png" ofType:nil]];
    [[XCHTTPClient sharedInstance] uploadWithURL:[NSURL URLWithString:@"http://www.uupoop.com/ico/?action=make"] parameter:@{@"aaa":@"vvbb"} fromData:data progress:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        self.progressView.progress = (float)totalBytesSent / totalBytesExpectedToSend;
    } completion:^(id responseObject, NSURLResponse *response) {
        NSString *string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:NULL] encoding:NSUTF8StringEncoding];
        self.textView.text = string;
    } failure:^(NSError *error) {
        self.textView.text = [error description];
    }];
}

- (IBAction)postAction:(id)sender
{
    [[XCHTTPClient sharedInstance] postWithURL:[NSURL URLWithString:@"http://baike.baidu.com/api/openapi/BaikeLemmaCardApi?scope=103&format=json&appid=379020&bk_length=600"] parameter:@{@"bk_key":@"app"} completion:^(id responseObject, NSURLResponse *response) {
        NSString *string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:NULL] encoding:NSUTF8StringEncoding];
        self.textView.text = string;
    } failure:^(NSError *error) {
        self.textView.text = [error description];
    }];
}

- (IBAction)getAction:(id)sender
{
    [[XCHTTPClient sharedInstance] getWithURL:[NSURL URLWithString:@"http://baike.baidu.com/api/openapi/BaikeLemmaCardApi?scope=103&format=json&appid=379020&bk_length=600"] parameter:@{@"bk_key":@"关键字"} completion:^(id responseObject, NSURLResponse *response) {
        NSString *string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:NULL] encoding:NSUTF8StringEncoding];
        self.textView.text = string;
    } failure:^(NSError *error) {
        self.textView.text = [error description];
    }];
}
@end
