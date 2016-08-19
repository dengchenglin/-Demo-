//
//  HomeToppicStreeTableViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/13.
//  Copyright (c) 2015年 YK. All rights reserved.
//

import UIKit

class HomeToppicStreeTableViewCell: UITableViewCell,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    @IBOutlet var tagView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    var toppicStreetModel: HomeTopicStreetModel!
    var view1 : TagView!
    var view2 : TagView!
    var timer : NSTimer!
    var currnetTag = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
         collectionView.registerNib(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.registerNib(UINib(nibName: "ToppicStreetCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ToppicStreetCollectionViewCell")
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    func show(model: HomeTopicStreetModel) {
        toppicStreetModel = model
        collectionView.reloadData()
        if view1 == nil {
            view1 = TagView(frame: CGRectMake(0, 0, 75, 30))
            view1.show(toppicStreetModel.toppicTagModelArray[0])
            tagView.addSubview(view1)
        }
       
        if view2 == nil {
            view2 = TagView(frame: CGRectMake(0, 30, 75, 30))
            view2.show(toppicStreetModel.toppicTagModelArray[1])
            tagView.addSubview(view2)
        }
        createTagView()
        
    }
    func createTagView() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
          timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "moveAction", userInfo: nil, repeats: true)
    }
    
    func moveAction() {
        if view1.top() == 0 {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.view1.frame = CGRectMake(0, -30, 75, 30)
                self.view2.frame = CGRectMake(0, 0, 75, 30)
            }, completion: { (finish) -> Void in
                self.currnetTag += 2
                if self.currnetTag >= self.toppicStreetModel.toppicTagModelArray.count {
                    self.currnetTag = 0
                }
                self.view1.frame = CGRectMake(0, 30, 75, 30)
                self.view1.show(self.toppicStreetModel.toppicTagModelArray[self.currnetTag])
            })
        }else {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.view1.frame = CGRectMake(0, 0, 75, 30)
                self.view2.frame = CGRectMake(0, -30, 75, 30)
            }, completion: { (finish) -> Void in
                self.currnetTag += 2
                if self.currnetTag >= self.toppicStreetModel.toppicTagModelArray.count {
                    self.currnetTag = 0
                }
                self.view2.frame = CGRectMake(0, 30, 75, 30)
                self.view2.show(self.toppicStreetModel.toppicTagModelArray[self.currnetTag])
            })
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if toppicStreetModel != nil {
            return 1 + toppicStreetModel.toppicListModelArray.count
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCollectionViewCell", forIndexPath: indexPath) as!ImageCollectionViewCell
            var model: ToppicTopModel
            cell.show(toppicStreetModel.toppicTopModelArray)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ToppicStreetCollectionViewCell", forIndexPath: indexPath) as!ToppicStreetCollectionViewCell
                let model = toppicStreetModel.toppicListModelArray[indexPath.item-1]
            cell.show(model)
            return cell

        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSizeMake(SCREEN_WIDTH, 100)
        }else {
            return CGSizeMake((SCREEN_WIDTH-0.1)/3.0, 100)
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
