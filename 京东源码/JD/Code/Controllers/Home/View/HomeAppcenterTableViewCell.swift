//
//  HomeAppcenterTableViewCell.swift
//  JD
//
//  Created by 岳坤 on 15/8/11.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit

class HomeAppcenterTableViewCell: UITableViewCell,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    var collectionView: UICollectionView!
    var dataSource:Array<HomeAppcenterModel> = Array()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        collectionView = UICollectionView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 180), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(collectionView)
        collectionView.registerClass(AppCenterCollectionViewCell.self, forCellWithReuseIdentifier: "AppCenterCell")
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(appCenterArray:Array<HomeAppcenterModel>) {
        dataSource.removeAll()
        for model in appCenterArray {
            dataSource.append(model)
        }
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataSource.count > 0 {
            return 8
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCellWithReuseIdentifier("AppCenterCell", forIndexPath: indexPath) as! AppCenterCollectionViewCell
        if indexPath.item != 7 {
            cell.show(dataSource[indexPath.item])
        }else{
            cell.show(dataSource.last!)
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((SCREEN_WIDTH - 50)/4, 75)
    }
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
