//
//  Home2LouTableViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class Home2LouTableViewCell: UITableViewCell {

    var cycleScrollView: CycleScrollView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.RGB(244, green: 244, blue: 244, alpha: 1)
        cycleScrollView = CycleScrollView(frame: CGRectMake(10, 10, SCREEN_WIDTH-20, 80))
        self.contentView.addSubview(cycleScrollView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func show(modelArray:Array<HomeStrategicItemModel>) {
        var imageArray: Array<String> = Array()
        for model in modelArray {
            imageArray.append(model.img)
        }
        cycleScrollView.showWithImageArray(imageArray)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
