//
//  MenuBar.swift
//  AcuDragon
//
//  Created by Emiko Clark on 1/23/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

class BaseCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews() {    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let menuImages = ["home","trending","subscriptions","account"]
    let menuTitle = ["Home","Trending","Subscription","Account"]
    
    lazy var collectionview : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        collectionview.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionview)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionview)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionview)
        
        // make the 1st icon selected whenever app starts
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionview.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: frame.size.width/4, height: frame.size.height)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.menuImageView.image = UIImage(named: menuImages[indexPath.row])?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 13, blue: 14)
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuCell : BaseCell {

    override func setupViews() {
        super.setupViews()
        
        addSubview(menuImageView)
        menuImageView.addConstraintsWithFormat(format: "H:[v0(40)]", views: menuImageView)
        menuImageView.addConstraintsWithFormat(format: "V:[v0(40)]", views: menuImageView)

        addConstraint(NSLayoutConstraint(item: menuImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX , multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: menuImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY , multiplier: 1, constant: 0))
    }

    override var isSelected: Bool {
        didSet {
            menuImageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }

    override var isHighlighted: Bool {
        didSet {
            menuImageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }

    let menuImageView : UIImageView = {
        let iv = UIImageView()
        // iv.image = UIImage(named: "dragon.png")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        iv.contentMode = .scaleAspectFit
        return iv
    }()


}



