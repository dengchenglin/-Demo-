//
//  HomeRecommendModel.swift
//  JD
//
//  Created by 岳坤 on 15/8/13.
//  Copyright (c) 2015年 YK. All rights reserved.
//

import UIKit

class HomeRecommendModel: NSObject {
//    "rcJumpType": 0,
//    "sourceValue": "6_0_CMSSH17946_1439433902",
//    "rcSourceValue": "6_0_CMSSH17946_1439433902_RIGHTCORNER",
//    "param": "",
//    "shareAvatar": "",
//    "img": "http://m.360buyimg.com/mobilecms/s260x348_jfs/t1822/339/49726643/61360/300dd13c/55cbffe4N9f1d330a.jpg!q70.jpg",
//    "shareTitle": "",
//    "rightCorner": "全部品牌",
//    "url": "http://sale.jd.com/app/act/s45H0aYTMzJor7b.html",
//    "shareContent": "",
//    "jumpTo": "",
//    "id": 17946,
//    "content": {},
//    "jumpType": 0,
//    "showName": "品牌墙",
//    "shareUrl": "http://sale.jd.com/app/act/s45H0aYTMzJor7b.html",
//    "rcJumpUrl": "http://sale.jd.com/app/act/JpYGabrZ1nSxi.html",
//    "isShare": 1,
//    "rcJumpTo": ""
    var rcJumpType: Int!
    var sourceValue: String!
    var rcSourceValue: String!
    var param: String!
    var shareAvatar: String!
    var img: String!
    var shareTitle: String!
    var rightCorner: String!
    var shareContent: String!
    var jumpTo: String!
    var id: Int!
    var content: Dictionary<String, AnyObject>!
    var jumpType: Int!
    var showName: String!
    var shareUrl: String!
    var rcJumpUrl: String!
    var isShare: Int!
    var rcJumpTo: String!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
