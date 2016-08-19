//
//  Swift-extension.swift
//  JD
//
//  Created by 岳坤 on 15/8/11.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

public let  SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
public let  SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height

//MARK: UIColor
extension UIColor {
    static func RGB(red:CGFloat,green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
       return  UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}

//MARK: UIView
extension UIView {
    
    func width() -> CGFloat {
       return self.frame.width
    }
    
    func height() -> CGFloat {
       return self.frame.height
    }
    
    func left() -> CGFloat {
       return  self.frame.origin.x
    }
    
    func right() -> CGFloat {
       return self.frame.origin.x + width()
    }
    
    func top() -> CGFloat {
        return self.frame.origin.y
    }
    
    func bottom() -> CGFloat {
        return self.frame.origin.y + height()
    }
}



//MARK: SDWebImage
extension UIButton {
    func DownLoadbackgroundImage(url: String, placehold: String?, state: UIControlState) {
        if placehold != nil {
            self.setBackgroundImage(UIImage(named: placehold!), forState: state)
        }
        self.sd_setBackgroundImageWithURL(NSURL(string: url), forState: state)
    }
}

extension UIImageView {
    func DownImage(url: String, placehold: String?) {
        if placehold != nil {
            self.image = UIImage(named: placehold!)
        }
        self.sd_setImageWithURL(NSURL(string: url))
    }
}