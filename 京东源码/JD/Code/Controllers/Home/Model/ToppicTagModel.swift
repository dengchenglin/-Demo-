//
//  ToppicTagModel.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class ToppicTagModel: NSObject {
    var name: String!
    var copy1: String!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if key == "copy" {
            copy1 = value as? String
        }
    }
}
