//
//  HomeTopicStreetModel.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class HomeTopicStreetModel: NSObject {
    var toppicTagModelArray: Array<ToppicTagModel> = Array()
    var toppicTopModelArray: Array<ToppicTopModel> = Array()
    var toppicListModelArray: Array<ToppicListModel> = Array()
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if key == "topicList" {
            let topicListArray = value as! Array<Dictionary<String,AnyObject>>
            for dict in topicListArray {
                let model = ToppicListModel()
                model.setValuesForKeysWithDictionary(dict)
                toppicListModelArray.append(model)
            }
        }else if key == "topTopic" {
            let topTopicArray = value as! Array<Dictionary<String,AnyObject>>
            for dict in topTopicArray {
                let model = ToppicTopModel()
                model.setValuesForKeysWithDictionary(dict)
                toppicTopModelArray.append(model)
            }

        }else if key == "tagList" {
            let tagListArray = value as! Array<Dictionary<String,AnyObject>>
            for dict in tagListArray {
                let model = ToppicTagModel()
                model.setValuesForKeysWithDictionary(dict)
                toppicTagModelArray.append(model)
            }

        }
    }
}
