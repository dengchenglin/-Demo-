//
//  HomeLocalShopTableViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/13.
//  Copyright (c) 2015年 YK. All rights reserved.
//

import UIKit

class HomeLocalShopTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    var dataSource: Array<HomeLocalShopModel> = Array()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.registerNib(UINib(nibName: "MoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoreCollectionViewCell")
        collectionView.registerNib(UINib(nibName: "LocalShopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LocalShopCollectionViewCell")
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
    func show(modelArray:Array<HomeLocalShopModel>) {
        dataSource.removeAll(keepCapacity: false)
        dataSource = modelArray
        collectionView.reloadData()
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataSource.count > 0 {
            return dataSource.count + 1
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.item == dataSource.count {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MoreCollectionViewCell", forIndexPath: indexPath) as! MoreCollectionViewCell
            return cell
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LocalShopCollectionViewCell", forIndexPath: indexPath) as! LocalShopCollectionViewCell
            cell.show(dataSource[indexPath.item])
            return cell

        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.item == dataSource.count {
            return CGSizeMake(30, 120)
        }else {
            return CGSizeMake(130, 120)
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
