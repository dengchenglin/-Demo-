//
//  MiaoShaModel.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class MiaoShaModel: NSObject {
    var adword: String!
    var cName: String!
    var discount: String!
    var discountNew: String!
    var expid: String!
    var good: String!
    var imageurl: String!
    var index: String!
    var moreFunId: String!
    var rate: String!
    var rid: String!
    var sourceValue: String!
    var startRemainTime: Int!
    var wname: String!
    var jdPrice: String!
    var miaoShaPrice: String!
    
    var promotion: Bool!
    var book: Bool!
    var canBuy: Bool!
    var canFreeRead: Bool!
    var miaoSha: Bool!
    
    var promotionId: Double!
    var wareId: Double!
    var spuId: Double!
    var activeId: Double!
    var endRemainTime: Int!

       override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
