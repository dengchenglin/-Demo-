//
//  HQFShowViewController.m
//  IOS
//
//  Created by qianfeng on 13-11-9.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFShowViewController.h"
#import "HQFAppDelegate.h"
#import "HQFBookModel.h"
#import "ASIHTTPRequest.h"
#import "GDataXMLNode.h"
#import "HQFYeMianModel.h"
#import "HQFSecondModel.h"
#import "HQFReaViewController.h"
#import "HQFBookSelfModel.h"

@interface HQFShowViewController ()
- (void)muLuFinished:(ASIHTTPRequest *)request;
-(void)addTableFooter;
- (void)settingFooter;
- (NSString *)getDataPath;
@end

@implementation HQFShowViewController
@synthesize delegeta;
@synthesize chapteridFirst;
@synthesize muLudegeta;


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
    self.myMuLuTableView.hidden = YES;
    [self addTableFooter];
    [self settingFooter];
    UISegmentedControl * segCtl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"内容简介:",@"目录", nil]];
    [segCtl setFrame:CGRectMake(15, 197, 140, 30)];
    //设置风格
    segCtl.segmentedControlStyle = UISegmentedControlStyleBar;
    segCtl.tintColor = [UIColor colorWithRed:125/255.0 green:184/255.0 blue:54/255.0 alpha:1];
    [segCtl addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segCtl];
    
    
}

- (void)segChange:(UISegmentedControl *)seg
{
    // 分段控制器段数
    //NSLog(@"seg is %d",seg.numberOfSegments);
    // 当前被用户点击的段落索引
    NSLog(@"select %d",seg.selectedSegmentIndex);
    
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            self.myMuLuTableView.hidden = YES;
        }
            break;
        case 1:
        {
            self.myMuLuTableView.hidden = NO;
            
            
            if (myShu) {
                HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
                HQFBookModel *model = (HQFBookModel *)[dele.dataArr objectAtIndex:myIndex];
                strUrl = [NSString stringWithFormat:@"http://a0.shuqireader.com/reader/bc_chapter.php?pagesize=30&bookId=%@&pageIndex=0&vid=0&isShowChapterInfo=true&Disclaime=true&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=374001384220307208&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",model.bookId];
            }
            else
            {
                strUrl = [NSString stringWithFormat:@"http://a0.shuqireader.com/reader/bc_chapter.php?pagesize=30&bookId=%@&pageIndex=1&vid=0&isShowChapterInfo=true&Disclaime=true&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=374001384220307208&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",secondBookId];
            }
            ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strUrl]];
            request1.tag = 200;
            request1.delegate = self;
            [request1 startAsynchronous];
        }
            break;
        default:
            break;
    }
}

- (void)secondIndex:(NSUInteger)secondIndex AndBookId:(NSString *)bookId AndBookName:(NSString *)bookName AndBookAouter:(NSString *)bookAouter AndType:(NSString *)bookType;
{
    sencondType = bookType;
    secondAouter = bookAouter;
    secondBookName = bookName;
    secondBookId = bookId;
    NSString *url = [NSString stringWithFormat:@"http://a0.shuqireader.com/reader/bc_cover.php?bookId=%@&Disclaime=true&user_id=164316646&book=same&book_num=1&otherbooks=5&lastchaps=1&keyword=keyword&keyword_num=3&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=131601384220084982&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",bookId];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.tag = 200;
    request.delegate = self;
    [request startAsynchronous];
}

- (void)scorllViewWithBookId:(NSString *)bookId AndClickShu:(NSInteger)shu
{
    selfBookId = bookId;
    myShu = shu;
    NSString *url = [NSString stringWithFormat:@"http://a0.shuqireader.com/reader/bc_cover.php?bookId=%@&Disclaime=true&user_id=164316646&book=same&book_num=1&otherbooks=5&lastchaps=1&keyword=keyword&keyword_num=3&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=131601384220084982&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",bookId];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request startAsynchronous];
}
- (void)tableViewCellIndex:(NSInteger)index Andshu:(NSInteger)shu
{
    myIndex = index;
    myShu = shu;
    HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
    HQFBookModel *model = (HQFBookModel *)[dele.dataArr objectAtIndex:index];
    NSString *url = [NSString stringWithFormat:@"http://a0.shuqireader.com/reader/bc_cover.php?bookId=%@&Disclaime=true&user_id=164316646&book=same&book_num=1&otherbooks=5&lastchaps=1&keyword=keyword&keyword_num=3&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=131601384220084982&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",model.bookId];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request startAsynchronous];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    pageIndex = 1;
}

- (IBAction)wCXiaZaiBtn:(UIButton *)sender {
    HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
    
    HQFReaViewController *readBook = [[HQFReaViewController alloc]init];
    self.delegeta = readBook;
    readBook.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:readBook animated:YES completion:nil];
    if (delegeta && [delegeta respondsToSelector:@selector(readBookId:AndChapterFirstId:)])
    {
        HQFBookModel *model = (HQFBookModel *)[dele.dataArr objectAtIndex:myIndex];
        NSArray *arr = [self readData];
        NSLog(@"=====%@",arr);
        for (HQFBookSelfModel *model1 in arr) {
            if ([model1.bookId isEqualToString:model.bookId]||[model1.bookName isEqualToString:self.myTitle.text]) {
                flag = YES;
            }
        }
        if (flag == NO||arr.count == 0) {
            if (myShu == 11) {
                HQFBookSelfModel *bookSelf = [[HQFBookSelfModel alloc]init];
                bookSelf.bookId = model.bookId;
                bookSelf.bookName = model.bookTitle;
                bookSelf.bookAouter = model.bookArtist;
                bookSelf.chapterId = chapteridFirst;
                bookSelf.bookType = @"连载";
                [dele.bookSelfArr addObject:bookSelf];
                
                
            }else if (myShu == 12)
            {
                NSLog(@"----11");
                HQFBookSelfModel *bookSelf = [[HQFBookSelfModel alloc]init];
                //bookSelf.bookId = model;
                bookSelf.bookName = self.myTitle.text;
                bookSelf.bookAouter =self.author.text;
                bookSelf.chapterId = chapteridFirst;
                bookSelf.bookType = @"连载";
                
                [dele.bookSelfArr addObject:bookSelf];

            }
            else
            {
                HQFBookSelfModel *bookSelf = [[HQFBookSelfModel alloc]init];
                bookSelf.bookId = secondBookId;
                bookSelf.bookName = secondBookName;
                bookSelf.bookAouter = secondAouter;
                bookSelf.bookType = sencondType;
                bookSelf.chapterId = chapteridFirst;
                NSLog(@"---111%@",bookSelf.bookType);
                NSLog(@"--------222%@",bookSelf.bookAouter);
                [dele.bookSelfArr addObject:bookSelf];
                
            }
           
        }
        if (myShu == 11) {
            [delegeta readBookId:model.bookId AndChapterFirstId:chapteridFirst];
        }else if (myShu == 12)
        {
            [delegeta readBookId:selfBookId AndChapterFirstId:chapteridFirst];
        }
        else
        {
            [delegeta readBookId:secondBookId AndChapterFirstId:chapteridFirst];
        }
        //创建一个data数据
        NSMutableData *datas = [NSMutableData data];
        //通过data创建一个编译器
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:datas];
        //编译数据模型，把数据模型转成data型，并且给其打上个key
        [archiver encodeObject:dele.bookSelfArr forKey:@"kDatas"];
        
        [archiver finishEncoding];
        
        //把编译后的data型数据写入创建好文件路径的文件夹中
        [datas writeToFile:[self getDataPath] atomically:YES];
    }
    
}

- (NSMutableArray *)readData
{
    //通过路径读取文件
    NSMutableData *datas = [NSMutableData dataWithContentsOfFile:[self getDataPath]];
    //创建一个解码器
    NSKeyedUnarchiver *unAarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:datas];
    //听过key取把数据模型给解码了
    

    NSMutableArray *bookSelf = [[NSMutableArray alloc]init];
    bookSelf = [unAarchiver decodeObjectForKey:@"kDatas"];
    [unAarchiver finishDecoding];
    return bookSelf;
    
}

- (NSString *)getDataPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
  //  NSString *path = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"archiver"];
    return [path stringByAppendingPathComponent:@"data.archiver"];
  //  return path;
}

#pragma mark--
#pragma mark 自定义函数
- (void)settingFooter
{
    //由于我们的自定义Tabbar高度高于系统默认，所以这里要调整tableView的内边距，以防止tabbar遮挡tableView
    //这里只把底部的内边距设为20，其他内边距为0
    //[self.myMuLuTableView setContentInset:UIEdgeInsetsMake(0, 0, 20, 0)];
    //改变分组TableView的默认底图，设置我们自己的颜色
    UIView *bgView=[[UIView alloc]initWithFrame:self.myMuLuTableView.frame];
    bgView.backgroundColor=[UIColor colorWithRed:244.0/255 green:244/255 blue:1 alpha:0];
    self.myMuLuTableView.backgroundView=bgView;
    self.myMuLuTableView.backgroundColor=[UIColor whiteColor];
}
//给table添加一个footerView
-(void)addTableFooter{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 50)];
    view.backgroundColor = [UIColor yellowColor];
    for (int i= 0; i<2; ++i) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 300+i;
        btn.frame=CGRectMake(10+210*i, 15, 50, 20);
        [btn setBackgroundImage:[self createImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
        if (i==0) {
            [btn setTitle:@"上一页" forState:UIControlStateNormal];
        }
        else
        {
            [btn setTitle:@"下一页" forState:UIControlStateNormal];
        }
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:12];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    [self.myMuLuTableView setTableFooterView:view];
}
//footview中自定义按键的的响应函数
int pageIndex = 1;
-(void)onBtnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 301:
        {
            
            HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
            HQFBookModel *model = (HQFBookModel *)[dele.dataArr objectAtIndex:myIndex];
            pageIndex++;
            if (pageIndex>myPageIndex/30+1) {
                myYeMianLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 360, 150, 20)];
                myYeMianLabel.backgroundColor = [UIColor blackColor];
                myYeMianLabel.textColor = [UIColor whiteColor];
                myYeMianLabel.textAlignment = NSTextAlignmentCenter;
                [self.view addSubview:myYeMianLabel];
                myYeMianLabel.text = @"已是最后一页";
                [UIView animateWithDuration:5 animations:^{
                    myYeMianLabel.alpha = 0;
                } completion:^(BOOL finished) {
                    if (finished) {
                        [myYeMianLabel removeFromSuperview];
                    }
                }];
                pageIndex = myPageIndex/30+1;
                NSLog(@"-------%d----",pageIndex);
                break;
            }
            if (myShu) {
                str1 = [NSString stringWithFormat:@"http://a0.shuqireader.com/reader/bc_chapter.php?pagesize=30&bookId=%@&pageIndex=%d&vid=0&isShowChapterInfo=true&Disclaime=true&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=374001384220307208&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",model.bookId,pageIndex];
            }
            else
            {
                str1 = [NSString stringWithFormat:@"http://a0.shuqireader.com/reader/bc_chapter.php?pagesize=30&bookId=%@&pageIndex=%d&vid=0&isShowChapterInfo=true&Disclaime=true&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=374001384220307208&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",secondBookId,pageIndex];
            }
            
            ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:str1]];
            request1.tag = 200;
            request1.delegate = self;
            [request1 startAsynchronous];
        }
            break;
            case 300:
        {
            HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
            HQFBookModel *model = (HQFBookModel *)[dele.dataArr objectAtIndex:myIndex];
            pageIndex--;
            if (pageIndex>=1) {
                if (myShu) {
                    str1 = [NSString stringWithFormat:@"http://a0.shuqireader.com/reader/bc_chapter.php?pagesize=30&bookId=%@&pageIndex=%d&vid=0&isShowChapterInfo=true&Disclaime=true&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=374001384220307208&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",model.bookId,pageIndex];
                }
                else
                {
                    str1 = [NSString stringWithFormat:@"http://a0.shuqireader.com/reader/bc_chapter.php?pagesize=30&bookId=%@&pageIndex=%d&vid=0&isShowChapterInfo=true&Disclaime=true&soft_id=1&ver=131025&platform=an&placeid=1075&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=374001384220307208&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",secondBookId,pageIndex];
                    NSLog(@"^^^^^^%d",pageIndex);
                }
                ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:str1]];
                request1.tag = 200;
                request1.delegate = self;
                [request1 startAsynchronous];
            }
            else
            {
                myYeMianLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 360, 150, 25)];
                myYeMianLabel.backgroundColor = [UIColor blackColor];
                NSLog(@"<<<<<<%@",myYeMianLabel);
                myYeMianLabel.text = @"已是第一页";
                myYeMianLabel.textColor = [UIColor whiteColor];
                myYeMianLabel.textAlignment = NSTextAlignmentCenter;
                [self.view addSubview:myYeMianLabel];
                [UIView animateWithDuration:5 animations:^{
                    myYeMianLabel.alpha = 0;
                } completion:^(BOOL finished) {
                    if (finished) {
                        [myYeMianLabel removeFromSuperview];
                    }
                }];
                pageIndex = 1;
                NSLog(@">>>>>%d>>>",pageIndex);
                break;
            }
        }
            break;
        default:
            break;
    }
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

#pragma mark --
#pragma mark ASIHTTPRequest的代理
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //创建xml解析器
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:[request responseData] options:0 error:nil];
    //xpath 描述节点位置
    NSString *xpath = @"/Book";
    NSArray *nodeArr = [document nodesForXPath:xpath error:nil];
    for (GDataXMLElement *elment in nodeArr) {
        HQFYeMianModel *shu = [[HQFYeMianModel alloc]init];
        GDataXMLElement *sub = [[elment elementsForName:@"BookName"] lastObject];
        GDataXMLElement *sub1 = [[elment elementsForName:@"BookType"] lastObject];
        GDataXMLElement *sub2 = [[elment elementsForName:@"NickName"] lastObject];
        GDataXMLElement *sub3 = [[elment elementsForName:@"Author"] lastObject];
        GDataXMLElement *sub4 = [[elment elementsForName:@"Description"] lastObject];
        GDataXMLElement *sub5 = [[elment elementsForName:@"Size"] lastObject];
        GDataXMLElement *sub6 = [[elment elementsForName:@"ImageExists"] lastObject];
        chapteridFirst = [[[elment elementsForName:@"ChapteridFirst"] lastObject] stringValue];
        NSLog(@"=========%@",self.chapteridFirst);
        shu.shuTitle = [sub stringValue];
        shu.shuTpye = [sub1 stringValue];
        shu.shuNickName = [sub2 stringValue];
        shu.shuAuthor = [sub3 stringValue];
        shu.shuDescription = [sub4 stringValue];
        shu.shuSize = [sub5 stringValue];
        
        strSize = [shu.shuDescription sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(280, 2000)];
        self.myScrollView.pagingEnabled = YES;
        self.myScrollView.bounces = NO;
        self.myScrollView.contentSize = CGSizeMake(strSize.width, strSize.height);
        
        self.myTextView.text = shu.shuDescription;
        self.myTextView.font = [UIFont systemFontOfSize:13];
        
        self.author.text = [NSString stringWithFormat:@"作者: %@",shu.shuAuthor];
        self.tpye.text = [NSString stringWithFormat:@"类别: %@",shu.shuNickName];
        self.size.text = [NSString stringWithFormat:@"数字: %@",shu.shuSize];
        
        if ([shu.shuTpye isEqualToString:@"连载"]) {
            self.myImgV.image = [UIImage imageNamed:@"书城-列表-连载.png"];
        }else
        {
            self.myImgV.image = [UIImage imageNamed:@"书城-列表-完结.png"];
        }
        self.myTitle.text = shu.shuTitle;
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[sub6 stringValue]]]];
        self.myImageView.image = img;
        
        
    }
    
    
    if (request.tag == 200) {
        HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
        [dele.muLuArr removeAllObjects];
        [self muLuFinished:request];
        [self.myMuLuTableView scrollRectToVisible:CGRectMake(0, -200,280,400) animated:NO];
        [self.myMuLuTableView reloadData];
    }
    
}

- (void)muLuFinished:(ASIHTTPRequest *)request
{
    HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
    //创建解析器
    GDataXMLDocument *doc1 = [[GDataXMLDocument alloc]initWithData:[request responseData] options:0 error:nil];
    NSArray *xxxArr = [doc1 nodesForXPath:@"/BookInfos" error:nil];
    GDataXMLNode *xxx = [[xxxArr lastObject] attributeForName:@"TotalCount"];
    myPageIndex = [[xxx stringValue] intValue];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:[request responseData] options:0 error:nil];
    //xpath 描述节点位置
    NSString *xpath = @"/BookInfos/Book";
    NSArray *muluArr = [doc nodesForXPath:xpath error:nil];
    for (GDataXMLElement *elment in muluArr) {
        HQFYeMianModel *muluModel = [[HQFYeMianModel alloc]init];
        GDataXMLNode *mulu = [elment attributeForName:@"BookChapter"];
        GDataXMLNode *muluUrl = [elment attributeForName:@"ContentURL"];
        GDataXMLNode *nextId = [elment attributeForName:@"ChapterId"];
        muluModel.ChapterId = [nextId stringValue];
        muluModel.muLu = [mulu stringValue];
        muluModel.muLuUrl = [muluUrl stringValue];
        [dele.muLuArr addObject:muluModel];
    }
    
}

#pragma mark --
#pragma mark textView代理
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

#pragma mark --
#pragma mark MuLuTableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
    return dele.muLuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
    HQFYeMianModel *muLuModel = (HQFYeMianModel *)[dele.muLuArr objectAtIndex:indexPath.row];
    cell.textLabel.text = muLuModel.muLu;
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQFReaViewController *read = [[HQFReaViewController alloc]init];
    
    self.muLudegeta = read;
    read.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:read animated:YES completion:nil];
    if (muLudegeta && [muLudegeta respondsToSelector:@selector(muLuChapterId:AndChapterFirst:AndBookId:)]) {
        if (myShu) {
            HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
            HQFBookModel *model = (HQFBookModel *)[dele.dataArr objectAtIndex:myIndex];
            [muLudegeta muLuChapterId:[self.chapteridFirst intValue]+indexPath.row AndChapterFirst:[self.chapteridFirst intValue] AndBookId:model.bookId];
        }
        else
        {
            [muLudegeta muLuChapterId:[self.chapteridFirst intValue]+indexPath.row AndChapterFirst:[self.chapteridFirst intValue] AndBookId:secondBookId];
        }
    }
}
@end
