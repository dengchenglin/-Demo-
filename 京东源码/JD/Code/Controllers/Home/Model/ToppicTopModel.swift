//
//  ToppicTopModel.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class ToppicTopModel: NSObject {
//    "bannerUrl": "http://m.360buyimg.com/mobilecms/s1242x430_jfs/t1657/161/1305671613/27785/9b636073/55c9b722N81fae367.jpg",
//    "url": "http://sale.jd.com/app/act/7aGrUYKNiDH3J.html",
//    "sourceValue": "0_16_CMSST16_0_",
//    "isSubscribed": 0,
//    "isShared": 1,
//    "tag": "低价",
//    "tagColor": 1,
//    "title": "母婴之家"
    var bannerUrl: String!
    var url: String!
    var sourceValue: String!
    var isSubscribed: Int!
    var isShared: Int!
    var tag: String!
    var tagColor: Int!
    var title: String!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
