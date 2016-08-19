//
//  HomeStrategicItemTableViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class HomeStrategicItemTableViewCell: UITableViewCell {

    @IBOutlet var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = UIColor.RGB(244, green: 244, blue: 244, alpha: 1)
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    func show(model: HomeStrategicItemModel) {
               iconImageView.DownImage(model.img, placehold: nil)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
