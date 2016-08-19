//
//  HomeViewController.swift
//  JD
//
//  Created by 岳坤 on 15/8/11.
//  Copyright © 2015年 YK. All rights reserved.
//

public enum JsonType: String {
    case banner = "banner"
    case appcenter = "appcenter"
    case miaoSha = "秒杀"
    case haohuo = "好货推荐"
    case erLou = "2楼"
    case tese =  "特色市场"
    case siLou = "4楼"
    case zhuti = "主题街"
    case wuLou = "5楼"
    case pinPai = "品牌推荐"
    case newFind = "新发现"
    case bendi = "本地生活楼层"
    case dianpu = "店铺"
}


import UIKit
import MJRefresh


class HomeViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var navigationView: UIView!
    @IBOutlet var tableView: UITableView!
    var dataSource: Array<Dictionary<String,AnyObject>> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView.backgroundColor = UIColor.RGB(252, green: 65, blue: 63, alpha: 0)
        tableView.backgroundColor = UIColor.RGB(244, green: 244, blue: 244, alpha: 1)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
       
        //注册Cell
        registerCell()
        
        //数据请求
        let  viewModel = HomeViewModel()
        viewModel.homeDataBlock = {
            self.dataSource.removeAll(keepCapacity: false)
            self.dataSource = $0
            self.tableView.reloadData()
        }
        viewModel.getHomePageData()
        
        //创建头部刷新
        createHeaderRefresh()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
//MARK: 注册Cell
    func registerCell() {
        tableView.registerClass(HomeBannerTableViewCell.self, forCellReuseIdentifier: "BannerCell")
        tableView.registerClass(HomeAppcenterTableViewCell.self, forCellReuseIdentifier: "AppCenterCell")
        tableView.registerNib(UINib(nibName: "HomeMiaoShaTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeMiaoShaCell")
        tableView.registerNib(UINib(nibName: "HomeStrategicItemTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeStrategicItemCell")
        tableView.registerNib(UINib(nibName: "HomeHaoHuoTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeHaoHuoCell")
        tableView.registerClass(Home2LouTableViewCell.self, forCellReuseIdentifier: "Home2LouTableViewCell")
        tableView.registerNib(UINib(nibName: "HomeTeSeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTeSeTableViewCell")
        tableView.registerNib(UINib(nibName: "HomeToppicStreeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeToppicStreeTableViewCell")
        tableView.registerNib(UINib(nibName: "HomeRecommendTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeRecommendTableViewCell")
        tableView.registerNib(UINib(nibName: "HomeNewFindTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeNewFindTableViewCell")
        tableView.registerNib(UINib(nibName: "HomeLocalLifeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeLocalLifeTableViewCell")
        tableView.registerNib(UINib(nibName: "HomeLocalShopTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeLocalShopTableViewCell")
    }

//MARK: 刷新相关
    func createHeaderRefresh() {
        let  mjHeader = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: "headerAction")
        mjHeader.setImages([UIImage(named: "deliveryStaff")!,UIImage(named: "deliveryStaff1")!,UIImage(named: "deliveryStaff2")!,UIImage(named: "deliveryStaff3")!], forState: MJRefreshStateIdle)
        mjHeader.setImages([UIImage(named: "deliveryStaff")!,UIImage(named: "deliveryStaff1")!,UIImage(named: "deliveryStaff2")!,UIImage(named: "deliveryStaff3")!], forState: MJRefreshStatePulling)
        mjHeader.setImages([UIImage(named: "deliveryStaff")!,UIImage(named: "deliveryStaff1")!,UIImage(named: "deliveryStaff2")!,UIImage(named: "deliveryStaff3")!], forState: MJRefreshStateRefreshing)
        mjHeader.stateLabel?.font = UIFont.boldSystemFontOfSize(12)
        mjHeader.stateLabel?.textColor = UIColor.whiteColor()
        mjHeader.lastUpdatedTimeLabel?.font = UIFont.boldSystemFontOfSize(12)
        mjHeader.lastUpdatedTimeLabel?.textColor = UIColor.whiteColor()
        tableView.header = mjHeader
    }
   
    
    func headerAction() {
        sleep(1)
        tableView.header.endRefreshing()
    }
    
//MARK: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let  dict = dataSource[indexPath.section]
        let  key = dict["key"] as! String
        let  enumKey = JsonType(rawValue: key)
        let value: AnyObject? = dict["value"]
        
    switch enumKey! {
        case .banner:
            let cell = tableView.dequeueReusableCellWithIdentifier("BannerCell") as! HomeBannerTableViewCell
            cell.show(value as! Array<HomeBannerModel>)
            return cell
        case .appcenter:
            let cell = tableView.dequeueReusableCellWithIdentifier("AppCenterCell") as! HomeAppcenterTableViewCell
            cell.show(value as! Array<HomeAppcenterModel>)
            return cell
        case .miaoSha:
            let cell = tableView.dequeueReusableCellWithIdentifier("HomeMiaoShaCell") as! HomeMiaoShaTableViewCell
            cell.show(value as! HomeMiaoShaModel)
            return cell
        case .haohuo:
            let cell = tableView.dequeueReusableCellWithIdentifier("HomeHaoHuoCell") as! HomeHaoHuoTableViewCell
            cell.show(value as! Array<HomeStrategicItemModel>)
            return cell
        case .erLou:
            let cell = tableView.dequeueReusableCellWithIdentifier("Home2LouTableViewCell") as! Home2LouTableViewCell
            cell.show(value as! Array<HomeStrategicItemModel>)
            return cell
        case .tese:
            let cell = tableView.dequeueReusableCellWithIdentifier("HomeTeSeTableViewCell") as! HomeTeSeTableViewCell
            cell.show(value as! Array<HomeStrategicItemModel>)
            return cell
        case .siLou :
            let cell = tableView.dequeueReusableCellWithIdentifier("Home2LouTableViewCell") as! Home2LouTableViewCell
            cell.show(value as! Array<HomeStrategicItemModel>)
            return cell
        case .zhuti :
            let cell = tableView.dequeueReusableCellWithIdentifier("HomeToppicStreeTableViewCell") as! HomeToppicStreeTableViewCell
            cell.show(value as! HomeTopicStreetModel )
            return cell
        case .wuLou :
            let cell = tableView.dequeueReusableCellWithIdentifier("Home2LouTableViewCell") as! Home2LouTableViewCell
            cell.show(value as! Array<HomeStrategicItemModel>)
            return cell
        case .pinPai :
            let cell = tableView.dequeueReusableCellWithIdentifier("HomeRecommendTableViewCell") as! HomeRecommendTableViewCell
            cell.show(value as! Array<HomeRecommendModel>)
            return cell
        case .newFind :
            let cell = tableView.dequeueReusableCellWithIdentifier("HomeNewFindTableViewCell") as! HomeNewFindTableViewCell
            cell.show(value as! Array<HomeRecommendModel>)
            return cell
        case .bendi :
            let cell = tableView.dequeueReusableCellWithIdentifier("HomeLocalLifeTableViewCell") as! HomeLocalLifeTableViewCell
            cell.show(value as! HomeRecommendModel)
            return cell
        case .dianpu :
            let cell = tableView.dequeueReusableCellWithIdentifier("HomeLocalShopTableViewCell") as! HomeLocalShopTableViewCell
            cell.show(value as! Array<HomeLocalShopModel> )
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let  dict = dataSource[indexPath.section]
        let  key = dict["key"] as! String
        let  enumKey = JsonType(rawValue: key)
        switch enumKey! {
            case .banner:
                return 180
            case .appcenter:
                return 180
            case .miaoSha:
                return 150
            case .haohuo:
                return 220
            case .erLou:
                return 100
            case .tese:
                return 160
            case .siLou :
                return 100
            case .zhuti :
                return 430
            case .wuLou :
                return 100
            case .pinPai :
                return 160
            case .newFind :
                return 130
            case .bendi :
                return 100
            case .dianpu :
                return 150
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let  dict = dataSource[section]
        let  key = dict["key"] as! String
        let  enumKey = JsonType(rawValue: key)
        switch enumKey! {
        case .banner:
            return 0.01
        case .appcenter:
            return 10
        case .miaoSha:
            return 0.01
        case .haohuo:
            return 0.01
        case .erLou:
            return 0.01
        case .tese:
            return 0.01
        case .siLou :
            return 0.01
        case .zhuti :
            return 0.01
        case .wuLou :
            return 100
        case .pinPai :
            return 10
        case .newFind :
            return 0.01
        case .bendi :
            return 0.01
        case .dianpu :
            return 0.01
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        navigationView.backgroundColor = UIColor.RGB(252, green: 65, blue: 63, alpha: scrollView.contentOffset.y * 0.01)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
