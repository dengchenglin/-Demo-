//
//  HomeMiaoShaTableViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class HomeMiaoShaTableViewCell: UITableViewCell,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet var showNameLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var rightCornerButton: UIButton!
    
    @IBOutlet var collectionView : UICollectionView!
    
    var homeMiaoShaModel : HomeMiaoShaModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.registerNib(UINib(nibName: "MiaoShaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MiaoShaCell")
        collectionView.registerNib(UINib(nibName: "MoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoreCell")
        self.selectionStyle = UITableViewCellSelectionStyle.None

    }

    func show(model: HomeMiaoShaModel) {
        homeMiaoShaModel = model
        collectionView.reloadData()
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if homeMiaoShaModel != nil {
            return homeMiaoShaModel.miaoshaArray.count + 1
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.item == homeMiaoShaModel.miaoshaArray.count {
            return CGSizeMake(30, 110)
        }else {
            return CGSizeMake(100, 110)
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.item == homeMiaoShaModel.miaoshaArray.count {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MoreCell", forIndexPath: indexPath) as! MoreCollectionViewCell
            return cell
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MiaoShaCell", forIndexPath: indexPath) as! MiaoShaCollectionViewCell
            cell.show(homeMiaoShaModel.miaoshaArray[indexPath.item])
            return cell
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentSize.width < scrollView.contentOffset.x + SCREEN_WIDTH {
            //滑动到边界
            sleep(1)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
