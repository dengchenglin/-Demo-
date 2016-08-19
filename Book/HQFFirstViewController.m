//
//  HQFFirstViewController.m
//  IOS
//
//  Created by qianfeng on 13-11-7.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFFirstViewController.h"
#import "HQFCommendView.h"
#import "HQFAppDelegate.h"
#import "HQFShowViewController.h"
#import "ASIHTTPRequest.h"
#import "GDataXMLNode.h"
#import "HQFBookModel.h"
#import "HQFBookCell.h"
#import "HQFSearchViewController.h"



@interface HQFFirstViewController ()
- (void)commendView;
@end

@implementation HQFFirstViewController
{
    UIScrollView *myScrollView;
    HQFShowViewController *showViewCtl;
    //UILabel *label;
    HQFAppDelegate *dele;
    // 与UIScrollview连用
    UIPageControl *pageCtl;
    
}

@synthesize delegate;
@synthesize isFirst;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)commendView
{
    for (int i = 0; i<6; ++i) {
        HQFCommendView *v = [[HQFCommendView alloc]initWithFrame:CGRectMake(320*i,0, 320, 100)];
        [myScrollView addSubview:v];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myTap:)];
        [v addGestureRecognizer:tap];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"HQFBookCell" bundle:nil] forCellReuseIdentifier:@"HQFBookCell"];
    
     dele = [UIApplication sharedApplication].delegate;

    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 47, 320, 100)];
    myScrollView.contentSize = CGSizeMake(320*6, 100);
    myScrollView.delegate = self;
    myScrollView.pagingEnabled = YES;
    myScrollView.bounces = NO;
    myScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:myScrollView];
    
    pageCtl = [[UIPageControl alloc]init];
    [pageCtl setFrame:CGRectMake(80, 125, 240, 20)];
    //决定UIPageControl显示几页
    pageCtl.numberOfPages = 6;
    [pageCtl addTarget:self action:@selector(myPageCtl) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageCtl];
    
    NSString *strURL = [NSString stringWithFormat:@"http://a0.shuqireader.com/reader/bc_reader_new_index.php?pageIndex=%d&num=20&booklist=booklist&clickrank=clickrank&newupdate=newupdate&newbook=newbook&appid=1&addr=rec&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=899731384219004606&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",arc4random()%5];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strURL]];
    request.delegate = self;
    [request startAsynchronous];
    
}

- (void)myTap:(UITapGestureRecognizer *)tap
{
    HQFCommendView *v = (HQFCommendView *)tap.view;
    HQFShowViewController *show = [[HQFShowViewController alloc]init];
    show.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.delegate = show;
    [self presentViewController:show animated:YES completion:nil];
    if (delegate && [delegate respondsToSelector:@selector(scorllViewWithBookId:AndClickShu:)]) {
        [delegate scorllViewWithBookId:v.bookId AndClickShu:12];
    }
}
- (void)myPageCtl
{
    //获取当前页码数 通过页码数＊320 计算出编译量
    NSUInteger num = pageCtl.currentPage;
    
    //以UIPageControl关联的事件
    [myScrollView scrollRectToVisible:CGRectMake(320*num, 0, 320, 220) animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark ASIHTTPRequest的代理

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    //创建xml解析器
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:[request responseData] options:0 error:nil];
    //xpath 描述节点位置
    NSString *xpath = @"/Items/Books/Book";
    NSArray *nodeArr = [document nodesForXPath:xpath error:nil];
    for (GDataXMLElement *element in nodeArr) {
        HQFBookModel *model = [[HQFBookModel alloc]init];
        GDataXMLNode *sub = [element attributeForName:@"title"];
        GDataXMLNode *sub1 = [element attributeForName:@"artist"];
        GDataXMLNode *sub2 = [element attributeForName:@"description"];
        GDataXMLNode *sub3 = [element attributeForName:@"imgurl"];
        GDataXMLNode *sub4 = [element attributeForName:@"booktype"];
        GDataXMLNode *sub5 = [element attributeForName:@"bid"];
        model.bookArtist = [sub1 stringValue];
        model.bookTitle =  [sub stringValue];
        model.bookDescription = [sub2 stringValue];
        model.bookType = [sub4 stringValue];
        model.imgurl = [sub3 stringValue];
        model.bookId = [sub5 stringValue];
        
        [dele.dataArr addObject:model];
        
    }
    
    [self commendView];
    [self.myTableView reloadData];
    
}

#pragma mark ---
#pragma mark tableView的代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dele.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQFBookCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"HQFBookCell"];
    if (cell == nil) {
        cell = [[HQFBookCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HQFBookCell"];
    }
    
    HQFBookModel *model = (HQFBookModel *)[dele.dataArr objectAtIndex:indexPath.row];
    cell.tag = 100+indexPath.row;
    cell.myTitle.text = model.bookTitle;
    cell.myTitle.textColor = [UIColor colorWithRed:46/255.0 green:124/255.0 blue:2/255.0 alpha:1];
    if (model.indexArr.count != 0) {
        for (NSString *str in model.indexArr) {
            if ([str intValue] == indexPath.row) {
                cell.myTitle.textColor = [UIColor blackColor];
            }
        }
    }
    cell.myCon.text = model.bookDescription;
    cell.myTpye.text = model.bookType;
    cell.myTpye.textColor = [UIColor orangeColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQFBookCell *cell = (HQFBookCell *)[self.view viewWithTag:100+indexPath.row];
    cell.myTitle.textColor = [UIColor blackColor];
    HQFBookModel *model = (HQFBookModel *)[dele.dataArr objectAtIndex:indexPath.row];
    
    [model.indexArr addObject:[NSString stringWithFormat:@"%d",indexPath.row]];
    
    showViewCtl = [[HQFShowViewController alloc]initWithNibName:@"HQFShowViewController" bundle:nil];
    showViewCtl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.delegate = showViewCtl;
    [self presentViewController:showViewCtl animated:YES completion:nil];
    
    if (delegate && [delegate respondsToSelector:@selector(tableViewCellIndex:Andshu:)]) {
        [delegate tableViewCellIndex:indexPath.row Andshu:11];
    }
    
    
}

#pragma mark -
#pragma mark UIScrollViewDelegate
//设置代理
//只要scrollView偏移量发生改变 自动调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
}
//停止减速时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView == myScrollView) {
        NSUInteger f = scrollView.contentOffset.x/320;
        pageCtl.currentPage = f;
    }
    
}


- (IBAction)mySearchBtn:(id)sender {
    HQFSearchViewController *search = [[HQFSearchViewController alloc]initWithNibName:@"HQFSearchViewController" bundle:nil];
    search.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:search animated:YES completion:nil];
    
}




@end
