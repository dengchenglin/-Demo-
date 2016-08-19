//
//  HomeNewFindTableViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/13.
//  Copyright (c) 2015年 YK. All rights reserved.
//

import UIKit

class HomeNewFindTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    var dataSource: Array<HomeRecommendModel> = Array()
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.registerNib(UINib(nibName: "HomeHaoHuoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeHaoHuoCollectionViewCell")
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    func show(modelArray: Array<HomeRecommendModel>) {
        dataSource.removeAll(keepCapacity: false)
        for model in modelArray {
            dataSource.append(model)
        }
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeHaoHuoCollectionViewCell", forIndexPath: indexPath) as! HomeHaoHuoCollectionViewCell
        cell.showNewFind(dataSource[indexPath.item])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if dataSource.count > 3 {
            if indexPath.item < 2 {
                return CGSizeMake(SCREEN_WIDTH/2, 100)
            }else {
                return CGSizeMake((SCREEN_WIDTH-0.1)/3, 100)
            }

        }else {
            return CGSizeMake((SCREEN_WIDTH-0.1)/3, 100)
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
