//
//  TagView.swift
//  JD
//
//  Created by 岳坤 on 15/8/13.
//  Copyright (c) 2015年 YK. All rights reserved.
//

import UIKit

class TagView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
     var tagButton: UIButton!

     var tagLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        tagButton = UIButton(frame: CGRectMake(0, 7, 35, 16))
        tagButton.setBackgroundImage(UIImage(named: "home_page_tag"), forState: UIControlState.Normal)
        tagButton.titleEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0)
        tagButton.titleLabel?.font = UIFont.boldSystemFontOfSize(12)
        self.addSubview(tagButton)
        
        tagLabel = UILabel(frame: CGRectMake(40, 0, 35, 30))
        tagLabel.font = UIFont.boldSystemFontOfSize(10)
        self.addSubview(tagLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func show(model: ToppicTagModel) {
        tagButton.setTitle(model.name, forState: UIControlState.Normal)
        tagLabel.text = model.copy1
    }
}
