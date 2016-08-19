//
//  CycleScrollView.swift
//  CycleScrollView
//
//  Created by 岳坤 on 15/8/10.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit
import SDWebImage
class CycleScrollView: UIView, UIScrollViewDelegate {
    var mainScrollView: UIScrollView!
    var pageControl: UIPageControl!
    var imagesArray:Array<String> = Array()
    var currentPage = 0
    var timer: NSTimer!
    var tapBlock: ((Int)->Void)?

//MARK: 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.mainScrollView = UIScrollView(frame: CGRectMake(0, 0, frame.width, frame.height))
        self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.width * 3, 0.0)
        self.mainScrollView.showsHorizontalScrollIndicator = false
        self.mainScrollView.pagingEnabled = true
        self.mainScrollView.bounces = false
        self.mainScrollView.delegate = self
        self.addSubview(self.mainScrollView)
        for (var i = 0; i < 3 ; i++) {
            let imageView = UIImageView(frame: CGRectMake(CGFloat(i)*self.mainScrollView.frame.width, 0, self.mainScrollView.frame.width, self.mainScrollView.frame.height))
            imageView.tag = 100 + i
            self.mainScrollView.addSubview(imageView)
            if i == 1 {
                let  tap = UITapGestureRecognizer(target: self, action: "tapAction")
                imageView.userInteractionEnabled = true
                imageView.addGestureRecognizer(tap)
            }
        }
        self.pageControl = UIPageControl(frame: CGRectMake(0, frame.height-25, frame.width, 37))
        self.pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        self.pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        self.addSubview(self.pageControl)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: 接收图片数组
    func showWithImageArray(imageArray: Array<String>) {
        imagesArray = imageArray
        if imagesArray.count > 1 {
            self.mainScrollView.scrollEnabled = true
        }else {
            self.mainScrollView.scrollEnabled = false
        }
        self.pageControl.numberOfPages = imagesArray.count
        ShowImage()
        createTimer()
    }
    
//MARK: 点击触发
    func tapAction() {
        if self.tapBlock != nil {
            self.tapBlock!(currentPage)
        }
    }
    
//MARK: 图片展示
    func ShowImage() {
        self.mainScrollView.contentOffset = CGPointMake(self.mainScrollView.frame.width, 0)
        self.pageControl.currentPage = currentPage
        for (var i = 0; i < 3; i++ ){
            let  imageView = self.mainScrollView.viewWithTag(100 + i) as! UIImageView
            let  index = getIndex(currentPage+i-1)
            imageView.DownImage(imagesArray[index], placehold: nil)
        }
    }
    func getIndex(nowIndex: Int) -> Int{
        var  index: Int
        if nowIndex < 0 {
            index = imagesArray.count - 1
        }else if nowIndex == imagesArray.count {
            index = 0
        }else {
            index = nowIndex
        }
        return index
    }
    
//MARK: NSTimer
    func createTimer() {
        if self.timer != nil {
            deallocTimer()
        }
        self.timer = NSTimer.scheduledTimerWithTimeInterval(4, target:self , selector: "timerAction", userInfo: nil, repeats: true)
    }
    func deallocTimer() {
        self.timer.invalidate()
        self.timer = nil
    }
    func timerAction() {
        self.mainScrollView.setContentOffset(CGPointMake(self.mainScrollView.contentOffset.x + self.mainScrollView.frame.width, 0), animated: true)
    }
    
//MARK: ScrollViewDelegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        deallocTimer()
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 2 * scrollView.frame.width {
            currentPage = getIndex(currentPage+1)
            ShowImage()
        }
        if scrollView.contentOffset.x == 0 {
            currentPage = getIndex(currentPage-1)
            ShowImage()
        }
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        createTimer()
    }
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
