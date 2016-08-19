//
//  AppCenterCollectionViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/11.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class AppCenterCollectionViewCell: UICollectionViewCell {
    var iconButton: UIImageView!
    var titleLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconButton = UIImageView(frame: CGRectMake((frame.width-50)/2, 0, 50, 50))
        iconButton.layer.masksToBounds = true
        iconButton.layer.cornerRadius = 5
        self.contentView.addSubview(iconButton)
        
        titleLabel = UILabel(frame: CGRectMake(0, iconButton.bottom()+5, frame.width, 20))
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont.systemFontOfSize(10)
        titleLabel.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(titleLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func show(appcenterModel: HomeAppcenterModel) {
        iconButton.DownImage(appcenterModel.icon, placehold: nil)
        titleLabel.text = appcenterModel.name
    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
