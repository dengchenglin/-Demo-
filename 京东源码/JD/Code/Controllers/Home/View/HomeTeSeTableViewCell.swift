//
//  HomeTeSeTableViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class HomeTeSeTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var icon1ImageView: UIImageView!
    @IBOutlet var icon2ImageView: UIImageView!
    @IBOutlet var icon3ImageView: UIImageView!
    @IBOutlet var icon4ImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None

        icon1ImageView.layer.borderWidth = 0.5
        icon1ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor
        icon2ImageView.layer.borderWidth = 0.5
        icon2ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor
        icon3ImageView.layer.borderWidth = 0.5
        icon3ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor
        icon4ImageView.layer.borderWidth = 0.5
        icon4ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor
        self.bringSubviewToFront(titleLabel)
        
    }
    func show(modelArray: Array<HomeStrategicItemModel>) {
        let  model1 = modelArray[0]
        icon1ImageView.DownImage(model1.img, placehold: nil)
        let  model2 = modelArray[1]
        icon2ImageView.DownImage(model2.img, placehold: nil)
        let  model3 = modelArray[2]
        icon3ImageView.DownImage(model3.img, placehold: nil)
        let  model4 = modelArray[3]
        icon4ImageView.DownImage(model4.img, placehold: nil)
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
