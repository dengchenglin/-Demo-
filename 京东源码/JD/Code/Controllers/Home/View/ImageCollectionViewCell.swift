//
//  ImageCollectionViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/13.
//  Copyright (c) 2015年 YK. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet var icon1ImageView: UIImageView!
    @IBOutlet var icon2ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func show(modelArry: Array<ToppicTopModel>) {
      let  model1 = modelArry[0]
        icon1ImageView.DownImage(model1.bannerUrl, placehold: nil)
        let mode2 = modelArry[1]
        icon2ImageView.DownImage(mode2.bannerUrl, placehold: nil)
    }
}
