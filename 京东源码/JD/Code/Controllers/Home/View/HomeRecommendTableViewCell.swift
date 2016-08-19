//
//  HomeRecommendTableViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/13.
//  Copyright (c) 2015年 YK. All rights reserved.
//

import UIKit

class HomeRecommendTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rightCornerButton: UIButton!
    
    @IBOutlet var backGroundView: UIView!
    @IBOutlet var icon1ImageView: UIImageView!
    @IBOutlet var icon2ImageView: UIImageView!
    @IBOutlet var icon3ImageView: UIImageView!
    @IBOutlet var icon4ImageView: UIImageView!
    @IBOutlet var icon5ImageView: UIImageView!
    @IBOutlet var icon6ImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        icon1ImageView.tag = 100
        icon1ImageView.layer.borderWidth = 0.3
        icon1ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor

        icon2ImageView.tag = 101
        icon2ImageView.layer.borderWidth = 0.3
        icon2ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor

        icon3ImageView.tag = 102
        icon3ImageView.layer.borderWidth = 0.3
        icon3ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor

        icon4ImageView.tag = 103
        icon4ImageView.layer.borderWidth = 0.3
        icon4ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor

        icon5ImageView.tag = 104
        icon5ImageView.layer.borderWidth = 0.3
        icon5ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor

        icon6ImageView.tag = 105
        icon6ImageView.layer.borderWidth = 0.3
        icon6ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor

        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    func show(modelArray: Array<HomeRecommendModel>) {
        let model1 = modelArray[0]
        titleLabel.text = model1.showName
        rightCornerButton.setTitle(model1.rightCorner, forState: UIControlState.Normal)
        icon1ImageView.DownImage(model1.img, placehold: nil)
        
        let model2 = modelArray[1]
        icon2ImageView.DownImage(model2.img, placehold: nil)
        let model3 = modelArray[2]
        icon3ImageView.DownImage(model3.img, placehold: nil)
        let model4 = modelArray[3]
        icon4ImageView.DownImage(model4.img, placehold: nil)
        let model5 = modelArray[4]
        icon5ImageView.DownImage(model5.img, placehold: nil)
        let model6 = modelArray[5]
        icon6ImageView.DownImage(model6.img, placehold: nil)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
