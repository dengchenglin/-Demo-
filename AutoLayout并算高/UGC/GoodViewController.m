//
//  GoodViewController.m
//  GeihuiWang
//
//  Created by chenguangjiang on 16/4/21.
//  Copyright © 2016年 qianmeng. All rights reserved.
//

#import "GoodViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "GoodCell.h"
@interface GoodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSArray * dataSoures;
@end

@implementation GoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self loadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}
-(void)createView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = self.view.backgroundColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"GoodCell" bundle:nil] forCellReuseIdentifier:@"GoodCell"];
    [self.view addSubview:_tableView];
//    self.tableView.estimatedRowHeight = 280;
//    self.tableView.rowHeight= UITableViewAutomaticDimension;
}
-(void)loadData{
    self.dataSoures = @[@"开始给谁看课施舍； 看wbow weohg ；owherogh b课噶恶化搞",@"是俄国weo;gh哦违和感啊；哦温哥华阿拉我噶骗人啊二楼多年的理念bawrnbawrhbrhawrlghwlrhgo'wrgl.sgn，啊喂难过；我和狗 i 为人类更好",@"efowej gwerg都；解放后；雷日啦耳机了；好啊额日；好啊；哦方便你飞奔了快半个图曝光日回归陪人家害怕而后；联合肉；个呼啦圈放那吧，让噶微软联合呢离开日回归能够日回归本色不能让科比个人联合国呢人离婚搞 前二后今儿；就会；饿哦如今他害怕；3集合基本面分；d.fbetjh",@"日回归陪人家害怕而后；联合肉；个呼啦圈放那吧，让噶微软联合呢离开日回归能够日回归本",@"噶微软联合呢离开日",@"rlghwlrhgo'wrgl.sgn，啊喂难过；我和狗 i 为人类更好",@"efowej gwerg都；解放后；雷日啦耳机了；好啊额日；好啊；哦方便你飞奔了快半个图曝光日回归"];
    [_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSoures.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodCell"];
    cell.contentLabel.text = self.dataSoures[indexPath.row];
    
    cell.contentLabel.preferredMaxLayoutWidth = self.view.bounds.size.width - 16;
//    NSLog(@"%f",cell.contentLabel.preferredMaxLayoutWidth);

    cell.imageHeight.constant = (self.view.frame.size.width - 16)/76*35;
    [cell updateConstraintsIfNeeded];

    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"GoodCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        ((GoodCell *)cell).contentLabel.text = [self.dataSoures objectAtIndex:indexPath.row];
    
    }];
    CGFloat height1 = [cell.contentView systemLayoutSizeFittingSize:CGSizeMake(self.tableView.bounds.size.width, MAXFLOAT)].height + 1;
    NSLog(@"%f",height);
    NSLog(@"%f",height1);
    return height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodCell"];
    cell.contentLabel.text = self.dataSoures[indexPath.row];
    return cell;
}
@end
