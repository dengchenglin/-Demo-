//
//  HQFFourViewController.m
//  IOS
//
//  Created by qianfeng on 13-11-7.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFFourViewController.h"
#import "HQFSQWebViewController.h"
#import "HQFStatementViewController.h"
#import "HQFLoginViewController.h"

@interface HQFFourViewController ()

@end

@implementation HQFFourViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ==
#pragma mark TableView的代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else
        return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = @[@"帐号管理",@"免责声明"];
    NSArray *arr1 = @[@"书旗网",@"为我打分",@"版本信息"];
    static NSString *cellid = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [arr1 objectAtIndex:indexPath.row];
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                HQFLoginViewController *login = [[HQFLoginViewController alloc]init];
                login.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self presentViewController:login animated:YES completion:nil];
            }
                break;
                case 1:
            {
                HQFStatementViewController *statement = [[HQFStatementViewController alloc]init];
                statement.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self presentViewController:statement animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row) {
            case 0:
            {
                HQFSQWebViewController *SQWeb = [[HQFSQWebViewController alloc]init];
                SQWeb.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self presentViewController:SQWeb animated:YES completion:nil];
            }
                break;
                case 1:
            {
                
            }
                break;
                case 2:
            {
                
            }
                break;
                
            default:
                break;
        }
    }
}

@end
