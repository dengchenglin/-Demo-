//
//  HomeHaoHuoCollectionViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class HomeHaoHuoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor
    }

    func show(model:HomeStrategicItemModel) {
        iconImageView.DownImage(model.img, placehold: nil)
    }
    
    func showNewFind(model: HomeRecommendModel) {
        iconImageView.DownImage(model.img, placehold: nil)
    }
}
