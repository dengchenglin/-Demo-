//
//  HomeMiaoShaModel.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class HomeMiaoShaModel: NSObject {
//    "rcJumpType": 1,
//    "sourceValue": "144_0_CMSSH3570_1439343138_2#miaosha-AL02-16-11100",
//    "advert": {
//    "advertJump": "miaoshaBrand",
//    "advertImg": ""
//    },
//    "rcSourceValue": "144_0_CMSSH3570_1439343138_RIGHTCORNER_2#miaosha-AL02-16-11100_全场9.9元起_miaosha",
//    "param": "",
//    "shareAvatar": "",
//    "img": "",
//    "shareTitle": "",
//    "rightCorner": "全场9.9元起",
//    "url": "",
//    "shareContent": "",
//    "jumpTo": "miaosha",
//    "id": 3570,
//    "miaoshaAdvance": 149,
//    "overTime": false,
//    "name": "8点场",
//    "algorithmFrom": "2#miaosha-AL02-16-11100",
//    "nextMiaoshaKey": "201508120000:1200",
//    "functionId": "indexMiaoShaArea"
    
    //    "content": {
    //    "message": "掌上秒杀",
    //    "timeRemain": 8864,
    //    "sourceValue": "2#miaosha-AL02-16-11100_16_27",
    //    "scheme": "B",
    //    "indexMiaoSha": []
    var rcJumpType: Int!
    var sourceValue: String!
    var advert: Dictionary<String,AnyObject>!
    var param: String!
    var shareAvatar: String!
    var rcSourceValue: String!
    var img: String!
    var shareTitle: String!
    var rightCorner: String!
    var url: String!
    var shareContent: String!
    var jumpTo: String!
    var id: Int!
    var miaoshaAdvance: Int!
    var overTime: Bool!
    var name: String!
    var algorithmFrom: String!
    var nextMiaoshaKey: String!
    var functionId: String!
    var miaoshaArray: Array<MiaoShaModel> = Array()
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if key == "content" {
            let contentDict = value as? NSDictionary
            let indexMiaoSha = contentDict!["indexMiaoSha"] as! Array<Dictionary<String,AnyObject>>
            for dict in indexMiaoSha {
                let miaoshaModel = MiaoShaModel()
                miaoshaModel.setValuesForKeysWithDictionary(dict)
                miaoshaArray.append(miaoshaModel)
            }
        }
    }
}
