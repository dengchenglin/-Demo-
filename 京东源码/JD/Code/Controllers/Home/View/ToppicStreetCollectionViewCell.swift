//
//  ToppicStreetCollectionViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/13.
//  Copyright (c) 2015年 YK. All rights reserved.
//

import UIKit

class ToppicStreetCollectionViewCell: UICollectionViewCell {
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var icon1ImageView: UIImageView!
    @IBOutlet var icon2ImageView: UIImageView!
    
    var imgList: Array<String> = Array()
    var timer: NSTimer!
    var currentCount = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor
    }
    func show(model: ToppicListModel) {
        icon1ImageView.DownImage(model.imgUrl, placehold: nil)
        if model.tag != nil {
            tagLabel.hidden = false
            tagLabel.text = model.tag
        }else {
            tagLabel.hidden = true
        }
        if timer != nil {
            timer.invalidate()
            timer = nil
            currentCount = 0
        }
        if model.imgList != nil {
            imgList = model.imgList
            timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "changeImage", userInfo: nil, repeats: true)
            timer.fireDate = NSDate.distantPast() as! NSDate
        }
    }
    
    func changeImage() {
        if currentCount >= imgList.count {
            currentCount = 0
        }
        icon2ImageView.DownImage(imgList[currentCount], placehold: nil)
        currentCount++
    }
}


