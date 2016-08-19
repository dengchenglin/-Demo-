//
//  HQFSecondViewController.m
//  IOS
//
//  Created by qianfeng on 13-11-7.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFSecondViewController.h"
#import "ASIHTTPRequest.h"
#import "GDataXMLNode.h"
#import "HQFSecondModel.h"
#import "HQFSexondCell.h"
#import "HQFShowViewController.h"
#import "HQFSearchViewController.h"

@interface HQFSecondViewController ()
- (void)showMenu;
- (void)hideMenu;
- (void)fenLeiBtn;
-(void)addTableFooter;
@end

@implementation HQFSecondViewController
{
    UIButton *fenLenBtn;
    NSArray *bookArr;
    NSString *bookName;
    NSInteger count;
}

@synthesize delegate;
@synthesize secondArr;

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
    count = 1;
    bookName = @"-1";
    [self addTableFooter];
    [self.myTableView registerNib:[UINib nibWithNibName:@"HQFSexondCell" bundle:nil] forCellReuseIdentifier:@"HQFSexondCell"];
    
    secondArr = [[NSMutableArray alloc]init];
    self.fenLeiView.hidden = YES;
    self.beiJingView.hidden = YES;

    NSString *url = @"http://a0.shuqireader.com/reader/bc_storylist.php?pagesize=60&PageType=rank&item=&pageIndex=1&cid=-1&need_more=2&appid=1&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=327111384343361080&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request startAsynchronous];
    
    [self fenLeiBtn];
}

- (void)fenLeiBtn
{
    bookArr = @[@"东方玄幻",@"转世重生",@"异世大陆",@"奇幻魔法",@"仙侠修真",@"架空历史",@"耽美小说",@"穿越小说",@"现代言情",@"古代言情",@"都市异能",@"都市情感",@"官场小说",@"黑道小说",@"休闲生活",@"中外文学",@"玩转职场",@"同人小说",@"科幻小说",@"综合书库",@"畅销热书",@"影视小说",@"推理小说",@"恐怖小说",@"网游小说",@"古典名著",@"军事小说",@"校园小说",@"体育竞技",@"武侠小说",@"显示全部"];
    for (int i = 0; i<8; ++i) {
        for (int j = 0; j<4; ++j) {
            int temp = 4*i+j;
            if (temp>30) {
                return;
            }
            fenLenBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [fenLenBtn setFrame:CGRectMake(10+70*j,30*i, 70, 30)];
            fenLenBtn.tag = 250 + temp;
            fenLenBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [fenLenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            fenLenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [fenLenBtn setTitle:[bookArr objectAtIndex:temp] forState:UIControlStateNormal];
            [fenLenBtn addTarget:self action:@selector(myClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.fenLeiView addSubview:fenLenBtn];
        }
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


bool flag = NO;
- (void)myClick:(UIButton *)fenLeiBtn1
{
    //NSLog(@">>>>>>>>>>>%d",fenLeiBtn1.tag);
    [self.myBtn setTitle:[bookArr objectAtIndex:fenLeiBtn1.tag - 250] forState:UIControlStateNormal];
    NSArray *arr = @[@"2",@"3",@"4",@"5",@"6",@"7",@"124",@"22",@"21",@"20",@"122",@"121",@"53",@"52",@"142",@"132",@"127",@"63",@"62",@"54",@"50",@"46",@"42",@"41",@"40",@"38",@"32",@"18",@"12",@"8",@"-1"];
    NSLog(@">>>>%@",[arr objectAtIndex:fenLeiBtn1.tag - 250]);
    [secondArr removeAllObjects];
    NSString *url = [NSString stringWithFormat:@"http://a0.shuqireader.com/reader/bc_storylist.php?pagesize=60&PageType=rank&item=&pageIndex=1&cid=%@&need_more=2&appid=1&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=327111384343361080&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",[arr objectAtIndex:fenLeiBtn1.tag - 250]];
    bookName = [arr objectAtIndex:fenLeiBtn1.tag-250];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request startAsynchronous];
    
    
    [self hideMenu];
    flag = !flag;
    
    
}

- (IBAction)myBtn:(UIButton *)sender {
    if (flag) {
        [self hideMenu];
    }
    else
    {
        [self showMenu];
    }
    flag = !flag;
}

- (IBAction)searchBtn:(id)sender {
    HQFSearchViewController *search = [[HQFSearchViewController alloc]initWithNibName:@"HQFSearchViewController" bundle:nil];
    search.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:search animated:YES completion:nil];
}

- (void)showMenu
{
    self.beiJingView.alpha = 0;
    self.beiJingView.hidden = NO;
    self.fenLeiView.frame = CGRectMake(10, -240+47, 300, 240);
    self.fenLeiView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.beiJingView.alpha = 0.4;
        self.fenLeiView.frame = CGRectMake(10,47, 300, 240);
    } completion:^(BOOL flag){
        self.myTableView.userInteractionEnabled = NO;
    }];

}

- (void)hideMenu
{
    [UIView animateWithDuration:0.5 animations:^{
        self.fenLeiView.frame = CGRectMake(10, -240+47, 300, 240);
        self.beiJingView.alpha = 0;
    } completion:^(BOOL flag){
        self.fenLeiView.hidden = NO;
        self.beiJingView.hidden = NO;
        self.myTableView.userInteractionEnabled = YES;
        
    }];
}

//通过颜色返回图片的函数
- (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
#pragma mark--
#pragma mark 自定义函数
//给table添加一个footerView（qq-设置里面的退出按键）
-(void)addTableFooter{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    view.hidden = YES;
    view.tag = 107;
    view.backgroundColor = [UIColor grayColor];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 320, 50);
    [btn addTarget:self action:@selector(onBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //[btn setBackgroundImage:[self createImageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"点击查找更多" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor blackColor];
    btn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    
    [view addSubview:btn];
    [self.myTableView setTableFooterView:view];
}
//footview中自定义按键的的响应函数
-(void)onBtnClick
{   count = count +1;
    NSString *url = [NSString stringWithFormat:@"http://a0.shuqireader.com/reader/bc_storylist.php?pagesize=60&PageType=rank&item=&pageIndex=%d&cid=%@&need_more=2&appid=1&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=327111384343361080&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",count,bookName];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    request.tag = 106;
    [request startAsynchronous];
}

////通过颜色返回图片的函数
//- (UIImage *)createImageWithColor:(UIColor *)color{
//    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return theImage;
//}
#pragma mark ---
#pragma mark ASIHTTPRequest代理方法
- (void)requestFinished:(ASIHTTPRequest *)request
{
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:[request responseData] options:0 error:nil];
    NSString *xpath = @"/BookInfos/Book";
    NSArray *nodeArr = [doc nodesForXPath:xpath error:nil];
    for (GDataXMLElement *element in nodeArr) {
        HQFSecondModel *model = [[HQFSecondModel alloc]init];
        GDataXMLNode *sub = [element attributeForName:@"BookName"];
        GDataXMLNode *sub1 = [element attributeForName:@"size"];
        GDataXMLNode *sub2 = [element attributeForName:@"TypeName"];
        GDataXMLNode *sub3 = [element attributeForName:@"BookDescribe"];
        GDataXMLNode *sub4 = [element attributeForName:@"BookId"];
        GDataXMLNode *sub5 = [element attributeForName:@"artist"];
        GDataXMLNode *sub6 = [element attributeForName:@"BookType"];
        model.bookName = [sub stringValue];
        model.bookSize = [sub1 stringValue];
        model.bookTpye = [sub2 stringValue];
        model.bookDescride = [sub3 stringValue];
        model.bookId = [sub4 stringValue];
        model.bookAouter = [sub5 stringValue];
        model.myTpye = [sub6 stringValue];
        [secondArr addObject:model];
    }
    if (request.tag != 106) {
        [self.myTableView scrollRectToVisible:CGRectMake(0, -47, 320, 480-67) animated:NO];
    }
    UIView *v = (UIView *)[self.view viewWithTag:107];
    v.hidden = NO;
    [self.myTableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"----------------");
}

#pragma mark --
#pragma TableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return secondArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQFSexondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HQFSexondCell"];
    if (cell == nil) {
        cell = [[HQFSexondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HQFSexondCell"];
    }
    HQFSecondModel *model = (HQFSecondModel *)[secondArr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myTitle.text = model.bookName;
    cell.myTitle.font = [UIFont systemFontOfSize:17];
    cell.myTitle.textColor = [UIColor colorWithRed:46/255.0 green:124/255.0 blue:2/255.0 alpha:1];
    cell.mySize.text = model.bookSize;
    cell.mySize.font = [UIFont systemFontOfSize:11];
    cell.myType.text = model.bookTpye;
    cell.myType.textColor = [UIColor orangeColor];
    cell.myType.font = [UIFont systemFontOfSize:13];
    cell.myDes.text = model.bookDescride;
    cell.myDes.font = [UIFont systemFontOfSize:12];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQFSecondModel *model = (HQFSecondModel *)[secondArr objectAtIndex:indexPath.row];
    HQFShowViewController *showCtl = [[HQFShowViewController alloc]init];
    showCtl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.delegate = showCtl;
    [self presentViewController:showCtl animated:YES completion:nil];
    
    if (delegate && [delegate respondsToSelector:@selector(secondIndex:AndBookId:AndBookName:AndBookAouter:AndType:)]) {
        [delegate secondIndex:indexPath.row AndBookId:model.bookId AndBookName:model.bookName AndBookAouter:model.bookAouter AndType:model.myTpye];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
@end
