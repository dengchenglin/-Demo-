//
//  HomeADTableViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/11.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class HomeBannerTableViewCell: UITableViewCell {
    var cycleScrollView : CycleScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cycleScrollView = CycleScrollView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 180))
        self.contentView.addSubview(cycleScrollView)
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(array: Array<HomeBannerModel>){
            var imageArray: Array<String> = Array()
            for model in array {
                imageArray.append(model.horizontalImag)
            }
            cycleScrollView.showWithImageArray(imageArray)
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
