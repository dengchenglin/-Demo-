//
//  MiaoShaCollectionViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class MiaoShaCollectionViewCell: UICollectionViewCell {
    @IBOutlet var iconImageView: UIImageView!

    @IBOutlet var jdPriceLabel: UILabel!
    
    @IBOutlet var discountNewLabel: UILabel!
    
    var lineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        discountNewLabel.layer.masksToBounds = true
        discountNewLabel.layer.cornerRadius = 5
        
        lineLabel = UILabel(frame: CGRectMake(99.5, 10, 0.5, 80))
        lineLabel.backgroundColor = UIColor.lightGrayColor()
        self.contentView.addSubview(lineLabel)
    }
    
    func show(model: MiaoShaModel) {
        iconImageView.DownImage(model.imageurl, placehold: nil)
        jdPriceLabel.text = "￥\(model.miaoShaPrice)"
        discountNewLabel.text = model.discountNew
    }

}
