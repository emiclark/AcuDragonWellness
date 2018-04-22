//
//  ViewController.swift
//  AcuDragon
//
//  Created by Emiko Clark on 1/22/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var cellHeight: CGFloat?
    var emptyState = true
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()

    var activityIndicator: UIActivityIndicatorView!
    let apiClient = ApiClient()
    let pageNum = 0

    // MARK:- View Methods
    override func viewWillAppear(_ animated: Bool) {
        initializeVideoModelForEmptyState()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiClient.delegate = self

        startActivityIndicator()
        print("============================\n")
        
        setupViewController()
        self.apiClient.fetchVideos(pageNum: pageNum)
        
    }
    
    // MARK:- Setup/Initialization Methods
    func initializeVideoModelForEmptyState() {
        
        // create empty video array for empty state
        let eva = Video() // video array initialized for empty state
        eva.etag = " "
        eva.items = [Items]()
        
        var itemsArr = Items()
        itemsArr.etag = " "
        itemsArr.channelTitle = " "
        itemsArr.id = Id()
        itemsArr.id?.playlistId = " "
        
        var snippet = Snippet()
        snippet.channelId = " "
        snippet.title = " "
        snippet.description = " "
        
        var videoThumbnails = VideoThumbnails()
        videoThumbnails.high = Thumbnails()
        
        videoThumbnails.high?.url = " "
        videoThumbnails.high?.height = 0
        videoThumbnails.high?.width = 0
        
        snippet.thumbnails = videoThumbnails
        itemsArr.snippet = snippet
        eva.items?.append(itemsArr)
        ApiClient.videosArray = eva
    }
    
    func setupViewController() {
        // Register cell
        self.collectionView!.register(VideoCell.self, forCellWithReuseIdentifier: "cellid")
        
        // adjust collectionview and scrollview to begin below menubar
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
       
        // constrain menu navBar label
        let navTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - view.frame.width/3, height: view.frame.height))
        navTitleLabel.text = "Acudragon Wellness System"
        navTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navTitleLabel.textColor = UIColor.white
        navigationItem.titleView = navTitleLabel
        collectionView?.backgroundColor = UIColor.white
                
        setupMenuBar()
    }

    private func setupMenuBar() {
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    // MARK:- CollectionView Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (ApiClient.videosArray.items?.count)!
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! VideoCell
        
        cell.videoItemSnippet = ApiClient.videosArray.items![indexPath.row].snippet
        apiClient.downloadImage(urlString: (cell.videoItemSnippet?.thumbnails?.high?.url!)!) { (thumbnailImage) in
            cell.thumbnailImageView.image = thumbnailImage
        }
        
        // calculate videoCell height and set cellHeight property
        setContentViewHeight(cell: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if emptyState {
            cellHeight = 295
            emptyState = false
        }
        
        return CGSize(width: view.frame.width, height: cellHeight!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK:- Helper Methods
    func startActivityIndicator() {
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activityIndicator.color = .blue
        self.activityIndicator.center = view.center
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)
        self.activityIndicator.hidesWhenStopped = false
        self.activityIndicator.startAnimating()
        view.addSubview(self.activityIndicator)
    }
    
    // calculate contentview height
    func setContentViewHeight(cell: VideoCell) {
        // returns cell height by calculating vertical heights and paddings of all objects
        
        let TNsize = cell.thumbnailImageView.systemLayoutSizeFitting(UICollectionViewFlowLayoutAutomaticSize)
        let Ssize = cell.stackText.systemLayoutSizeFitting(UICollectionViewFlowLayoutAutomaticSize)
        let L1size = cell.titleLabel.systemLayoutSizeFitting(UICollectionViewFlowLayoutAutomaticSize)
        let L2size = cell.subTitleTextView.systemLayoutSizeFitting(UICollectionViewFlowLayoutAutomaticSize)

        // sum of all padding between videoCell objects
        let alpha = 16+10+16
        let size = TNsize.height + Ssize.height + CGFloat(alpha)
        print("\ncellHeight: \(cellHeight!), size: \(size):, Thumb:\(TNsize), stackSize: \(Ssize), alpha: \(alpha), - [l1:\(L1size), l2:\(L2size)]")
        cellHeight = CGFloat(size)
    }
}

// MARK:- Extensions
extension HomeController : reloadDataDelegate {
    func updateUI() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.collectionView?.reloadData()
    }
}


//========

//========= attempt to calculate cell height - doesn't set cellHeight correctly ==========
//    func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
////        setNeedsLayout()
////        layoutIfNeeded()
//
//        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        var newFrame = layoutAttributes.frame
//        // note: don't change the width
//        newFrame.size.height = ceil(size.height)
//        layoutAttributes.frame = newFrame
//        return layoutAttributes
//    }


//    // calculate contentview height
//    func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//
//        let size = cell.contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        var newFrame = layoutAttributes.frame
//        // note: don't change the width
//        newFrame.size.height = ceil(size.height)
//        layoutAttributes.frame = newFrame
//        return layoutAttributes
//    }




//func getVideoCellHeight(cell: VideoCell) {
//    // returns cell height by calculating vertical heights and paddings of all objects
//    let TNsize = cell.thumbnailImageView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
//    let Ssize = cell.stackText.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
//    //        let L1size = cell.titleLabel.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
//    //        let L2size = cell.subTitleTextView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
//    // sum of all padding between videoCell objects
//    let alpha = 16+10+16
//    let size = TNsize.height + Ssize.height + CGFloat(alpha)
//    //        let size = TNsize.height + L1size.height + L2size.height + CGFloat(alpha)
//    //        print(TNsize,L1size,L2size,alpha)
//    print("size: \(size)::, \(TNsize),\(Ssize),\(alpha)")
//    cellHeight = CGFloat(size)
//}



//func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let imageShowingWidth: CGFloat = self.view.frame.width / CGFloat(self.howManyImageShowing)
//
//    let labelName = "@\(self.tweetShowing[indexPath.row].user.screenName) (\(self.tweetShowing[indexPath.row].user.name))"
//    let labelNameFont: UIFont = UIFont(name: "PingFangTC-Semibold", size: 16)!
//    let labelNameWidth: CGFloat = self.view.frame.width - YourWidthOffSet// (YourWidthOffSet include all images' width and all margins)
//    let labelNameHeight: CGFloat = self.getHeightForLable(labelWidth: labelNameWidth, labelText: labelName, labelFont: labelNameFont)
//
//    let labelContentFont: UIFont = UIFont(name: "PingFangTC-Regular", size: 16)!
//    let labelContentHeight: CGFloat = self.getHeightForLable(labelWidth: labelNameWidth, numberOfLines: 0, labelText: self.tweetShowing[indexPath.row].text, labelFont: labelContentFont)
//
//    let cellHeight: CGFloat = labelNameHeight + labelContentHeight + YourHeightOffSet // (YourHeightOffSet means all margins)
//
//    return self.typeControl.selectedSegmentIndex == 0 ? CGSize(width: self.view.frame.width, height: cellHeight) : CGSize(width: imageShowingWidth, height: imageShowingWidth)
//}
//
//func getHeightForLable(labelWidth: CGFloat, numberOfLines: Int = 1, labelText: String, labelFont: UIFont) -> CGFloat {
//    let tempLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
//    tempLabel.numberOfLines = numberOfLines
//    tempLabel.text = labelText
//    tempLabel.font = labelFont
//    tempLabel.sizeToFit()
//    return tempLabel.frame.height
//}
//
