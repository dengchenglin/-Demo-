//
//  HQFSearchViewController.m
//  IOS
//
//  Created by qianfeng on 13-11-19.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFSearchViewController.h"
#import "ASIHTTPRequest.h"
#import "GDataXMLNode.h"
#import "HQFSearchModel.h"
#import "HQFSearchCell.h"
#import "HQFSearViewController.h"

@interface HQFSearchViewController ()

@end

@implementation HQFSearchViewController

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
    
    _searchArr = [[NSMutableArray alloc]init];
    _searchCtl = [[UISearchDisplayController alloc]initWithSearchBar:self.mySearch contentsController:self];
    [_searchCtl.searchResultsTableView registerNib:[UINib nibWithNibName:@"HQFSearchCell" bundle:nil] forCellReuseIdentifier:@"HQFSearchCell"];
    _searchCtl.searchResultsDataSource = self;
    _searchCtl.searchResultsDelegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



#pragma mark ==
#pragma mark  TableView得代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQFSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HQFSearchCell"];
    if (cell==nil) {
        cell = [[HQFSearchCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HQFSearchCell"];
    }
    HQFSearchModel *model = (HQFSearchModel *)[_searchArr objectAtIndex:indexPath.row];
    cell.seachBookName.text = model.bookName;
    
    cell.searchAuthor.text = [NSString stringWithFormat:@"作者：%@  %@",model.authorName,model.searchStatus];
    cell.searchType.text = model.searchType;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQFSearchModel *model = (HQFSearchModel *)[_searchArr objectAtIndex:indexPath.row];
    HQFSearViewController *sear = [[HQFSearViewController alloc]initWithNibName:@"HQFSearViewController" bundle:nil AndBookId:model.searchBookId];
    NSLog(@"-----%@",model.searchBookId);
    sear.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:sear animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark == 
#pragma UISearchBarDelegate代理
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"----------1111");
    NSString *searchURL = [NSString stringWithFormat:@"http://api3.shuqireader.com/ppso_search_interface.php?action=bookname&keyword=%@&pagesize=30&pageindex=1&soft_id=1&ver=131112&platform=an&placeid=1024&imei=860139027899033&cellid=0&lac=-1&sdk=16&wh=480x854&imsi=&msv=3&enc=636271384761099181&sn=1370756087618650&vc=8b6b&mod=MI+1S&net_type=wifi&first_placeid=src1075&aak=d535a9&user_id=164316646&session=cBYQBqB2R2Xdc5BMYcR5dM",self.mySearch.text];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[searchURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    request.delegate = self;
    [request startAsynchronous];
    
}

#pragma mark ==
#pragma mark  ASIHTTPRequestDelegate得代理
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    [_searchArr removeAllObjects];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:[request responseData] options:0 error:nil];
    NSArray *nodeArr = [doc nodesForXPath:@"/Books/Book" error:nil];
    for (GDataXMLElement *element in nodeArr) {
        HQFSearchModel *model = [[HQFSearchModel alloc]init];
        GDataXMLNode *bookName = [element attributeForName:@"bookName"];
        GDataXMLNode *authorName = [element attributeForName:@"authorName"];
        GDataXMLNode *searchBookId = [element attributeForName:@"bookId"];
        GDataXMLNode *searchType = [element attributeForName:@"type"];
        GDataXMLNode *searchStatus = [element attributeForName:@"status"];
        model.bookName = [bookName stringValue];
        model.authorName = [authorName stringValue];
        model.searchBookId = [searchBookId stringValue];
        model.searchType = [searchType stringValue];
        model.searchStatus = [searchStatus stringValue];
        [_searchArr addObject:model];
    }
    NSLog(@"-----%d",_searchArr.count);
    [_searchCtl.searchResultsTableView scrollRectToVisible:CGRectMake(0, -200, 320, 480) animated:YES];
    [_searchCtl.searchResultsTableView reloadData];
}

- (IBAction)searchBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
