//
//  LocalShopCollectionViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/13.
//  Copyright (c) 2015年 YK. All rights reserved.
//

import UIKit

class LocalShopCollectionViewCell: UICollectionViewCell {
    @IBOutlet var icon1ImageView: UIImageView!
    @IBOutlet var icon2ImageView: UIImageView!
    @IBOutlet var icon3ImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        icon1ImageView.layer.masksToBounds = true
        icon1ImageView.layer.cornerRadius = 5
        icon1ImageView.layer.borderWidth = 1
        icon1ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor
        
        icon2ImageView.layer.masksToBounds = true
        icon2ImageView.layer.cornerRadius = 5
        icon2ImageView.layer.borderWidth = 1
        icon2ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor

        icon3ImageView.layer.masksToBounds = true
        icon3ImageView.layer.cornerRadius = 5
        icon3ImageView.layer.borderWidth = 1
        icon3ImageView.layer.borderColor = UIColor.RGB(240, green: 240, blue: 240, alpha: 1).CGColor

    }
    
    func show(model: HomeLocalShopModel) {
        nameLabel.text  = model.name
        icon1ImageView.DownImage(model.image1, placehold: nil)
        icon2ImageView.DownImage(model.image2, placehold: nil)
        icon3ImageView.DownImage(model.image3, placehold: nil)
    }

}
