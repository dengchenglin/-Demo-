 //
//  HomeViewModel.swift
//  JD
//
//  Created by 岳坤 on 15/8/11.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

let  KEY = "key"
let VALUE = "value"
 
class HomeViewModel: NSObject {
    
    var homeDataBlock: ((dataArray: Array<Dictionary<String,AnyObject>>) -> Void)!
    var homeDataArray: Array<Dictionary<String,AnyObject>> = Array()
       //获取首页数据
    func getHomePageData() {
        homeDataArray.removeAll(keepCapacity: false)
        
        let path = NSBundle.mainBundle().pathForResource("Home", ofType: "json")
        let  jsonData = NSData(contentsOfFile: path!)
        let  jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? Dictionary<String, AnyObject>
        if jsonDict != nil {
            let  floorListArray  = jsonDict!["floorList"] as? Array<Dictionary<String,AnyObject>>
            for dict in floorListArray! {
                let type = dict["type"] as? String
                switch type! {
                case "banner":
                    getBannerData(dict)
                case "appcenter":
                    getAppcenterData(dict)
                case "hybrid":
                    let  showName = dict["showName"] as? String
                    switch showName! {
                    case "通栏秒杀":
                        getMiaoShaData(dict)
                    case "战略单品+闪购夜市":
                        getStrategicItemData(dict)
                    case "好货推荐":
                        getHaoHuoData(dict)
                    case "2楼","4楼","5楼":
                        get2LouData(dict)
                    case "特色市场 ":
                        getTeSeData(dict)
                    case "品牌推荐":
                        getRecommendData(dict)
                    case "新发现":
                        getNewFindData(dict)
                    case "本地生活楼层":
                            getLocalLifeData(dict)
                    case "店铺街楼层":
                        getFeaturedShop(dict)
                        default:
                        break
                    }
                case "indexTopicStreet":
                    getTopicStreetData(dict)
                   
                default:
                    break
                }
                if homeDataBlock != nil {
                    homeDataBlock(dataArray: homeDataArray)
                }
            }
        }

//        do {
//            let  jsonDict = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as? Dictionary<String, AnyObject>
//            if jsonDict != nil {
//                let  floorListArray  = jsonDict!["floorList"] as? Array<Dictionary<String,AnyObject>>
//                for dict in floorListArray! {
//                    let type = dict["type"] as? String
//                    switch type! {
//                        case "banner":
//                            getBannerData(dict)
//                        case "appcenter":
//                            getAppcenterData(dict)
//                        case "hybrid":
//                            let  showName = dict["showName"] as? String
//                            switch showName! {
//                                case "通栏秒杀":
//                                    getMiaoShaData(dict)
//                                case "战略单品+闪购夜市":
//                                    getStrategicItemData(dict)
//                                case "好货推荐":
//                                     getHaoHuoData(dict)
//                                case "2楼":
//                                    get2LouData(dict)
//                                case "特色市场 ":
//                                    getTeSeData(dict)
//                                case "4楼":
//                                    get2LouData(dict)
//                                default:
//                                    break
//                            }
//                        case "indexTopicStreet":
//                            getTopicStreetData(dict)
//                        default:
//                            break
//                    }
//                }
//            }
//        } catch {
//            
//        }
    }
    
//MARK: Banner
    func getBannerData(dict: Dictionary<String, AnyObject>) {
        let contentArray = dict["content"] as? Array<Dictionary<String,AnyObject>>
        if contentArray != nil {
            var  adModelArray: Array<HomeBannerModel> = Array()
            for contentDict in contentArray! {
                let  adModel = HomeBannerModel()
                adModel.setValuesForKeysWithDictionary(contentDict)
                adModelArray.append(adModel)
            }
            let dict = [KEY: JsonType.banner.rawValue,VALUE:adModelArray]
            homeDataArray.append(dict as! Dictionary<String, AnyObject>)
        }
    }
    
//MARK: Appcenter
    func getAppcenterData(dict: Dictionary<String, AnyObject>) {
        let contentDict = dict["content"] as? Dictionary<String,AnyObject>
        let dataArray = contentDict!["data"] as? Array<Dictionary<String,AnyObject>>
        if dataArray != nil {
            var  appcenterArray: Array<HomeAppcenterModel> = Array()
            for dataDict in dataArray! {
                let  appcenterModel = HomeAppcenterModel()
                appcenterModel.setValuesForKeysWithDictionary(dataDict)
                appcenterArray.append(appcenterModel)
            }
            let dict = [KEY: JsonType.appcenter.rawValue,VALUE:appcenterArray]
            homeDataArray.append(dict as! Dictionary<String, AnyObject>)
            
        }
    }
    
//MARK: 秒杀数据
    func getMiaoShaData(dict: Dictionary<String, AnyObject>) {
        let contentDict = dict["content"] as? Dictionary<String,AnyObject>
        let  subFloors = contentDict!["subFloors"] as? Array<Dictionary<String,AnyObject>>
        if subFloors != nil {
            let  subFloorDict = subFloors!.first
            if subFloorDict != nil {
                let  dataArray = subFloorDict!["data"] as? Array<Dictionary<String,AnyObject>>
                let dataDict = dataArray!.first
                let miaoshaModel = HomeMiaoShaModel()
                miaoshaModel.setValuesForKeysWithDictionary(dataDict!)
                let dict = [KEY: JsonType.miaoSha.rawValue,VALUE:miaoshaModel]
                homeDataArray.append(dict)
            }
        }
    }
    
    func getStrategicItemData(dict: Dictionary<String, AnyObject>) {
        let contentDict = dict["content"] as? Dictionary<String,AnyObject>
        let  subFloors = contentDict!["subFloors"] as? Array<Dictionary<String,AnyObject>>
        if subFloors != nil {
            let  subFloorDict = subFloors!.first
            if subFloorDict != nil {
                let  dataArray = subFloorDict!["data"] as? Array<Dictionary<String,AnyObject>>
                let dataDict = dataArray!.first
                let strategicItemModel = HomeStrategicItemModel()
                strategicItemModel.setValuesForKeysWithDictionary(dataDict!)
                let dict = [KEY: JsonType.zhuti.rawValue,VALUE:strategicItemModel]
                homeDataArray.append(dict)
            }
        }

    }

    func getHaoHuoData(dict: Dictionary<String, AnyObject>) {
        let contentDict = dict["content"] as? Dictionary<String,AnyObject>
        let  subFloors = contentDict!["subFloors"] as? Array<Dictionary<String,AnyObject>>
        var  haoHuoModelArray: Array<HomeStrategicItemModel> = Array()
        for subFloorDict in subFloors! {
            let  dataArray = subFloorDict["data"] as? Array<Dictionary<String,AnyObject>>
            for dict in dataArray! {
                let  model = HomeStrategicItemModel()
                model.setValuesForKeysWithDictionary(dict)
                haoHuoModelArray.append(model)
            }
        }
        let dict = [KEY: JsonType.haohuo.rawValue,VALUE:haoHuoModelArray]
        homeDataArray.append(dict as! Dictionary<String, AnyObject>)
    }
    
    func get2LouData(dict: Dictionary<String, AnyObject>) {
        let contentDict = dict["content"] as? Dictionary<String,AnyObject>
        let  subFloors = contentDict!["subFloors"] as? Array<Dictionary<String,AnyObject>>
        if subFloors != nil {
            let  subFloorDict = subFloors!.first
            if subFloorDict != nil {
                let  dataArray = subFloorDict!["data"] as? Array<Dictionary<String,AnyObject>>
                var  modelArray: Array<HomeStrategicItemModel> = Array()
                 for dataDict in dataArray! {
                    let strategicItemModel = HomeStrategicItemModel()
                    strategicItemModel.setValuesForKeysWithDictionary(dataDict)
                    modelArray.append(strategicItemModel)
                }
                let dict = [KEY: JsonType.erLou.rawValue,VALUE:modelArray]
                homeDataArray.append(dict as! Dictionary<String, AnyObject>)
            }
        }
    }
    
    func getTeSeData(dict: Dictionary<String, AnyObject>) {
        let contentDict = dict["content"] as? Dictionary<String,AnyObject>
        let  subFloors = contentDict!["subFloors"] as? Array<Dictionary<String,AnyObject>>
        if subFloors != nil {
            let  subFloorDict = subFloors!.first
            if subFloorDict != nil {
                let  dataArray = subFloorDict!["data"] as? Array<Dictionary<String,AnyObject>>
                var  modelArray: Array<HomeStrategicItemModel> = Array()
                for dataDict in dataArray! {
                    let strategicItemModel = HomeStrategicItemModel()
                    strategicItemModel.setValuesForKeysWithDictionary(dataDict)
                    modelArray.append(strategicItemModel)
                }
                let dict = [KEY: JsonType.tese.rawValue,VALUE:modelArray]
                homeDataArray.append(dict as! Dictionary<String, AnyObject>)
            }
        }
    }
    
    func getTopicStreetData(dict: Dictionary<String, AnyObject>) {
        let contentDict = dict["content"] as? Dictionary<String,AnyObject>
        let  model = HomeTopicStreetModel()
        model.setValuesForKeysWithDictionary(contentDict!)
        let dict = [KEY: JsonType.zhuti.rawValue,VALUE:model]
        homeDataArray.append(dict)
    }
    
    func getRecommendData(dict: Dictionary<String, AnyObject>) {
        let contentDict = dict["content"] as? Dictionary<String,AnyObject>
        let  subFloors = contentDict!["subFloors"] as? Array<Dictionary<String,AnyObject>>
        if subFloors != nil {
            let  subFloorDict = subFloors!.first
            if subFloorDict != nil {
                let  dataArray = subFloorDict!["data"] as? Array<Dictionary<String,AnyObject>>
                var  modelArray: Array<HomeRecommendModel> = Array()
                for dataDict in dataArray! {
                    let model = HomeRecommendModel()
                    model.setValuesForKeysWithDictionary(dataDict)
                    modelArray.append(model)
                }
                let dict = [KEY: JsonType.pinPai.rawValue,VALUE:modelArray]
                homeDataArray.append(dict as! Dictionary<String, AnyObject>)
            }
        }
    }
    
    func getNewFindData(dict: Dictionary<String, AnyObject>) {
        let contentDict = dict["content"] as? Dictionary<String,AnyObject>
        let  subFloors = contentDict!["subFloors"] as? Array<Dictionary<String,AnyObject>>
        if subFloors != nil {
            var  modelArray: Array<HomeRecommendModel> = Array()
            for subFloorDict in subFloors! {
                let  dataArray = subFloorDict["data"] as? Array<Dictionary<String,AnyObject>>
                for dataDict in dataArray! {
                    let model = HomeRecommendModel()
                    model.setValuesForKeysWithDictionary(dataDict)
                    modelArray.append(model)
                }
            }
            let dict = [KEY: JsonType.newFind.rawValue,VALUE:modelArray]
            homeDataArray.append(dict as! Dictionary<String, AnyObject>)
        }
    }
    
    func getLocalLifeData(dict: Dictionary<String, AnyObject>) {
        let contentDict = dict["content"] as? Dictionary<String,AnyObject>
        let  subFloors = contentDict!["subFloors"] as? Array<Dictionary<String,AnyObject>>
        if subFloors != nil {
            let  subFloorDict = subFloors!.first
            if subFloorDict != nil {
                let  dataArray = subFloorDict!["data"] as? Array<Dictionary<String,AnyObject>>
                let  dataDict = dataArray?.first
                let model = HomeRecommendModel()
                model.setValuesForKeysWithDictionary(dataDict!)
                let dict = [KEY: JsonType.bendi.rawValue,VALUE:model]
                homeDataArray.append(dict)
            }
        }
    }
    
    func getFeaturedShop(dict: Dictionary<String, AnyObject>) {
        let contentDict = dict["content"] as? Dictionary<String,AnyObject>
        let  subFloors = contentDict!["subFloors"] as? Array<Dictionary<String,AnyObject>>
        if subFloors != nil {
            let  subFloorDict = subFloors!.first
            if subFloorDict != nil {
                let  dataArray = subFloorDict!["data"] as? Array<Dictionary<String,AnyObject>>
                let  dataDict = dataArray?.first
                let  content = dataDict!["content"] as? Dictionary<String,AnyObject>
                let resultArray = content!["result"] as? Array<Dictionary<String,AnyObject>>
                var  modelArray: Array<HomeLocalShopModel> = Array()
                for dict in resultArray! {
                    let model = HomeLocalShopModel()
                    model.setValuesForKeysWithDictionary(dict)
                    modelArray.append(model)
                }
                let dict = [KEY: JsonType.dianpu.rawValue,VALUE:modelArray]
                homeDataArray.append(dict as! Dictionary<String, AnyObject>)
            }
        }

    }

}
