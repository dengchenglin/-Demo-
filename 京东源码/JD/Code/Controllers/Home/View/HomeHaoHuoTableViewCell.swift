//
//  HomeHaoHuoTableViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/12.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class HomeHaoHuoTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    var dataSource: Array<HomeStrategicItemModel> = Array()
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.registerNib(UINib(nibName: "HomeHaoHuoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HaoHuoCell")
        self.selectionStyle = UITableViewCellSelectionStyle.None

    }
    
    func show(modelArray: Array<HomeStrategicItemModel>) {
        dataSource = modelArray
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCellWithReuseIdentifier("HaoHuoCell", forIndexPath: indexPath) as! HomeHaoHuoCollectionViewCell
        cell.show(dataSource[indexPath.item])
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(SCREEN_WIDTH/3, 110)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
