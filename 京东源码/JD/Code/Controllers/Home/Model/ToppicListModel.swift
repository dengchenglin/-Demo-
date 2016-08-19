//
//  TopicListModel.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class ToppicListModel: NSObject {
    var imgUrl: String!
    var imgList: Array<String>!
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

