//
//  HQFThreeViewController.m
//  IOS
//
//  Created by qianfeng on 13-11-7.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFThreeViewController.h"
#import "HQFAppDelegate.h"
#import "HQFBookSelfModel.h"
#import "HQFThreeCell.h"
#import "HQFReaViewController.h"

@interface HQFThreeViewController ()

@end

@implementation HQFThreeViewController
@synthesize delegate;

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
    [self.shuJiaTableView registerNib: [UINib nibWithNibName:@"HQFThreeCell" bundle:nil] forCellReuseIdentifier:@"HQFThreeCell"];
}
//试图即将出现的时候
- (void)viewDidAppear:(BOOL)animated{
    [self.shuJiaTableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bianJiBtn:(UIButton *)sender {
    // 表格处于编辑与非编辑状态
    BOOL flag = self.shuJiaTableView.editing;
    if (flag) {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
    }
    else
    {
        [sender setTitle:@"完成" forState:UIControlStateNormal];
    }
    flag = !flag;
    [self.shuJiaTableView setEditing:flag animated:YES];
}
- (NSString *)getDataPath
{
    //
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
  //  NSString *path = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"archiver"];
    return [path stringByAppendingPathComponent:@"data.archiver"];
  //  return path;
}

//获取保存HQFBookSelfModel的数组
- (NSMutableArray *)readData
{
    //通过路径读取文件
    NSMutableData *datas = [NSMutableData dataWithContentsOfFile:[self getDataPath]];
    //创建一个解码器
    NSKeyedUnarchiver *unAarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:datas];
    //听过key取把数据模型给解码了
    HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
    NSLog(@"-----%@",dele.bookSelfArr);

    dele.bookSelfArr = [[unAarchiver decodeObjectForKey:@"kDatas"] mutableCopy];
    [unAarchiver finishDecoding];
    NSLog(@"read>>>>%@", [self getDataPath]);

    return dele.bookSelfArr;
    
    
    
}

//通过路径解码
- (void)readData:(NSInteger)index
{
    //通过路径读取文件
    NSMutableData *datas = [NSMutableData dataWithContentsOfFile:[self getDataPath]];
    //创建一个解码器
    NSKeyedUnarchiver *unAarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:datas];
    //听过key取把数据模型给解码了
    HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
    dele.bookSelfArr = [unAarchiver decodeObjectForKey:@"kDatas"];
    [unAarchiver finishDecoding];
    HQFBookSelfModel *moled = (HQFBookSelfModel *)dele.bookSelfArr[index];
    bookName = moled.bookName;
    bookId = moled.bookId;
    chapterId = [moled.chapterId intValue];
    bookAouter = moled.bookAouter;
    bookType = moled.bookType;
    NSLog(@"--boosk-%@",bookId);
    
    
}

#pragma mark --
#pragma mark tableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self readData].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQFThreeCell *cell = [self.shuJiaTableView dequeueReusableCellWithIdentifier:@"HQFThreeCell"];
    if (cell == nil) {
        cell = [[HQFThreeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HQFThreeCell"];
    }
    [self readData:indexPath.row];
    cell.myTitle.text = bookName;
    cell.myTitle.textColor = [UIColor colorWithRed:46/255.0 green:124/255.0 blue:2/255.0 alpha:1];
    cell.myAouter.text = [NSString stringWithFormat:@"作者: %@",bookAouter];
    cell.myType.text = bookType;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQFReaViewController *read = [[HQFReaViewController alloc]init];
    self.delegate = read;
    read.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:read animated:YES completion:nil];
    if (delegate && [delegate respondsToSelector:@selector(bookId: AndChapterId:)]) {
        [delegate bookId:bookId AndChapterId:chapterId];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 获取cell上的delete按钮点击事件
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"my delete...%d %d",indexPath.section,indexPath.row);
        // 删除数据源 只要数组发生变化就必须要归档一次
        HQFAppDelegate *dele = [UIApplication sharedApplication].delegate;
        [dele.bookSelfArr removeObjectAtIndex:indexPath.row];
        NSMutableData *datas = [NSMutableData data ];
        NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:datas];
        [arch encodeObject:dele.bookSelfArr forKey:@"kDatas"];
        [arch finishEncoding];
        [datas writeToFile:[self getDataPath]atomically:YES];
        
        // 刷新tableView
        // 所有的tableView代理方法全部重新执行一遍
        [tableView reloadData];
    }
    
}


@end
