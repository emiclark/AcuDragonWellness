//
//  ViewController.swift
//  AcuDragon
//
//  Created by Emiko Clark on 1/22/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    //    var videoItem = VideoCell()
    
    var stackHeight: CGFloat = 100.0
    
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
        let eva = Video()
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
        
//        cell.profileImageView.image = #imageLiteral(resourceName: "dragon")
//        
//        cell.titleLabel.text =  cell.videoItemSnippet?.title != nil ?  cell.videoItemSnippet?.title : "AcuDragon Wellness System"
//
//        cell.subTitleTextView.text =  cell.videoItemSnippet?.description != nil ?  cell.videoItemSnippet?.description : "    "
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: (height + stackHeight))
//        return CGSize(width: view.frame.width, height: height + 16 + 20)
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
}

// MARK:- Extensions
extension HomeController : reloadDataDelegate {
    func updateUI() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.collectionView?.reloadData()
    }
}

