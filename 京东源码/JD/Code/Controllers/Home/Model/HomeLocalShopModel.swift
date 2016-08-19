//
//  HomeLocalShopModel.swift
//  JD
//
//  Created by 岳坤 on 15/8/13.
//  Copyright (c) 2015年 YK. All rights reserved.
//

import UIKit

class HomeLocalShopModel: NSObject {
//    "shopId": 29859,
//    "shopName": "三只松鼠旗舰店",
//    "shopCategories": {
//    "name": "精选",
//    "cid": ""
//    },
//    "followCount": 0,
//    "followed": false,
//    "hasPromotion": false,
//    "hasNewWare": false,
//    "hasDown": false,
//    "sourceValue": "1_0_CMSDP",
//    "wareList": [
//    {
//    "wareId": 0,
//    "imgPath": "http://m.360buyimg.com/n1/jfs/t1588/86/549886819/341383/3088fb75/5594a949Ne1fe7ead.jpg!q70.jpg!q70.jpg"
//    },
//    {
//    "wareId": 0,
//    "imgPath": "http://m.360buyimg.com/n1/jfs/t796/39/1150258071/274797/58def4fb/557b8d43N71a03539.jpg!q70.jpg!q70.jpg"
//    },
//    {
//    "wareId": 0,
//    "imgPath": "http://m.360buyimg.com/n1/jfs/t793/109/1165646039/293721/824c6095/557b85aaNac8dd984.jpg!q70.jpg!q70.jpg"
//    }
//    ]

    var shopId: Int!
    var shopName: String!
    var name: String!
    var followCount: Int!
    var followed: Bool!
    var hasPromotion: Bool!
    var hasNewWare: Bool!
    var hasDown: Bool!
    var sourceValue: String!
    var cid: String!
    var image1: String!
    var image2: String!
    var image3: String!
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if key == "shopCategories" {
            let dict = value as! NSDictionary
            name = dict.objectForKey("name") as? String
            cid = dict.objectForKey("cid") as? String
            
        }
        if key == "wareList" {
            let array = value as! NSArray
            let  dict1 = array.objectAtIndex(0) as! NSDictionary
            image1 = dict1.objectForKey("imgPath") as? String
            let  dict2 = array.objectAtIndex(1) as! NSDictionary
            image2 = dict2.objectForKey("imgPath") as? String
            let  dict3 = array.objectAtIndex(2) as! NSDictionary
            image3 = dict3.objectForKey("imgPath") as? String
        }
     }
}
