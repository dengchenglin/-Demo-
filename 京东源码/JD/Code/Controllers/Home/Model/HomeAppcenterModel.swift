//
//  HomeAppcenterModel.swift
//  JD
//
//  Created by 岳坤 on 15/8/11.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class HomeAppcenterModel: NSObject {
    var sourceValue: String!
    var icon: String!
    var actionType: Int!
    var id: Int!
    var slogan: String!
    var cornerIcon: String!
    var share: Dictionary<String,AnyObject>!
    var order: Int!
    var name: String!
    var appCode: String!
    var needLogin: Int!
    var nativeJumpType: String!
    var notificationEnable: Int!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
