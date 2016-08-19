//
//  HomeLocalLifeTableViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/13.
//  Copyright (c) 2015年 YK. All rights reserved.
//

import UIKit

class HomeLocalLifeTableViewCell: UITableViewCell {

    @IBOutlet var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func show(model: HomeRecommendModel) {
        iconImageView.DownImage(model.img, placehold: nil)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
