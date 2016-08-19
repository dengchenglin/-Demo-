//
//  ViewController.m
//  AutoLayoutDemo
//
//  Created by chenguangjiang on 15/10/21.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "ViewController.h"
#import "GoodViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "XIBCell.h"
#import "CodeCell.h"
@interface ViewController ()
@property(nonatomic,strong)NSArray *dataSoures;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSoures = @[@"sakflabgablss",@"as;ojflshvlnxhgrolnslgbskfbkjwhelnsf.nbxknchwoegnlshkugdbfkbhbdfcuhghnldfjb;gjrhgdlkfild;hdf",@"sfdil;dfjlkmxzkklfisjglsfhnlgfdnsdfbdhdhdfghf",@"sgpojglhdjfhohpihgoiwrhgiubgdfjhgoeirg",@"ifhgliehohdlfihblidhflig",@"sojgpaiejrphgeroighnahlifdhgnd,jhgoilrhpeahoihjpawrjh[jaerphjearhpea;jrhpeajrhpjep",@"xlcihbrshpsdhvlnxcbohslbnwoehrlbsn0ohwlrbishnlbnoahfn,jdbukvBS,FBkshfgoiwrHGOuwkbkslDNKjhgoweihgskjdbvkjsbvkbskrguwHGKUHwghw",@"DJGVLSIAHGOHWRIGOHSOGHAWORHGAGEURNUHIGUWRHIHGAORHOGIE",@"lsihgIUWEHGOIhsoiehgoWEHGLWHGILHGSIHEJOIHGLHLAESHGIE"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XIBCell" bundle:nil] forCellReuseIdentifier:@"XIBCell"];
    if([[UIDevice currentDevice].systemVersion compare:@"8.0"]){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
   return self.dataSoures.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  

    
    if(indexPath.row < 3){
        static NSString *identifier = @"codeCell";
        CodeCell *codeCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(codeCell == nil){
            codeCell = [[CodeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [codeCell fillData:[self.dataSoures objectAtIndex:indexPath.row]];
        return [codeCell systemLayoutSizeFittingSize:CGSizeMake(self.tableView.bounds.size.width, 1000)].height + 1;
    }
    
    if(indexPath.row < 5){
        return [tableView fd_heightForCellWithIdentifier:@"XIBCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            ((XIBCell *)cell).content.text = [self.dataSoures objectAtIndex:indexPath.row];
        }];
    }
    
    
    if(indexPath.row < 8){
        return UITableViewAutomaticDimension;//ios8以上
    }
    
    XIBCell *xibCell = [tableView dequeueReusableCellWithIdentifier:@"XIBCell"];

    
    xibCell.content.text = [self.dataSoures objectAtIndex:indexPath.row];
    
   
   //  _xibcell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(_xibcell.bounds));
    xibCell.content.preferredMaxLayoutWidth = tableView.bounds.size.width - 18;
    [xibCell updateConstraintsIfNeeded];
    return [xibCell.contentView systemLayoutSizeFittingSize:CGSizeMake(self.tableView.frame.size.width, 1000)].height + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row < 3){
        static NSString *identifier = @"codeCell";
        CodeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil){
            cell  = [[CodeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell fillData:[self.dataSoures objectAtIndex:indexPath.row]];
        return cell;
    }
    
    XIBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XIBCell"];
    if(cell == nil){
        cell = [[NSBundle mainBundle] loadNibNamed:@"XIBCell" owner:nil options:nil][0];
    }
    cell.content.text = [self.dataSoures objectAtIndex:indexPath.row];
    return cell;
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodViewController *good = [[GoodViewController alloc]init];
    [self presentViewController:good animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
