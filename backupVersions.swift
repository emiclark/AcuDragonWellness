//
//  backupVersions.swift
//  AcuDragon
//
//  Created by Emiko Clark on 4/10/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

//import Foundation

//================================
// bakup setupviews w/ stacktext

//override func setupViews() {
//    backgroundColor = UIColor.white
//    addSubview(thumbnailImageView)
//    addSubview(separaterView)
//    addSubview(profileImageView)
//    addSubview(stackText)
//
//    // add title and subtitle to stackText
//    stackText.addArrangedSubview(titleLabel)
//    stackText.addArrangedSubview(subTitleTextView)
//    stackText.translatesAutoresizingMaskIntoConstraints = false
//    stackText.axis = .vertical
//    stackText.distribution = .fill
//    stackText.spacing = 4
//
//    // stackText constraints
//    stackText.isLayoutMarginsRelativeArrangement = true
//    stackText.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    stackText.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 4).isActive = true
//    stackText.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12).isActive = true
//    stackText.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 0).isActive = true
//    stackText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
//
//    //thumbnail constraint
//    NSLayoutConstraint.activate([
//        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
//        thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//        thumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//        thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
//        thumbnailImageView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: -8)
//        ])
//
//    //profile image constraint
//    NSLayoutConstraint.activate([
//        profileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
//        profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//        profileImageView.widthAnchor.constraint(equalToConstant: 44),
//        profileImageView.heightAnchor.constraint(equalToConstant: 44)
//        ])
//
//    // separator constraints
//    NSLayoutConstraint.activate([
//        separaterView.topAnchor.constraint(equalTo: subTitleTextView.bottomAnchor),
//        separaterView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//        separaterView.heightAnchor.constraint(equalToConstant: 1),
//        separaterView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//        separaterView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//        ])
//}

//============================================
// backup 4/15 b4 stackviews
////
////  VideoCell.swift
////  AcuDragon
////
////  Created by Emiko Clark on 1/23/18.
////  Copyright © 2018 Emiko Clark. All rights reserved.
////
//
//import UIKit
//
//class VideoCell: BaseCell {
//
//    var videoItem = Items()
//    var delegate: reloadDataDelegate?
//
//    enum MyKeys: String, CodingKey {
//        case thumbnail = "thumbnails"
//        case urlString = "url"
//    }
//
//
//    var videoItemSnippet: Snippet? {
//        didSet {
//
//            if let thumbnailUrlString = videoItemSnippet?.thumbnails?.high?.url {
//                downloadImage(imageType: "videoThumbnail", urlString: thumbnailUrlString)
//            }
//
//            titleLabel.text = videoItemSnippet?.title
//
//            if let channelSubtitle = videoItemSnippet?.description {
//                subTitleTextView.text = channelSubtitle
//            }
//
//            if let title = videoItemSnippet?.title {
//                titleLabel.text = title
//            }
//
//            if let channelDescription = videoItemSnippet?.description {
//                subTitleTextView.text = channelDescription
//            }
//        }
//    }
//
//    let thumbnailImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 8
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = UIColor( red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0 ).cgColor
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = #imageLiteral(resourceName: "dragonPlaceholder")
//        return imageView
//    }()
//
//    var profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.layer.cornerRadius = 22
//        imageView.layer.masksToBounds = true
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = #imageLiteral(resourceName: "dragon")
//        return imageView
//    }()
//
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.frame.size.height = 20
//        label.backgroundColor = UIColor.yellow
//        label.sizeToFit()
//        return label
//    }()
//
//    let subTitleTextView: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = UIColor.cyan
//        label.sizeToFit()
//        return label
//    }()
//
//    let separaterView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 230/255)
//        return view
//    }()
//
//    var titleLabelHeightConstraint: NSLayoutConstraint?
//    var subTitleLabelHeightConstraint: NSLayoutConstraint?
//
//    override func setupViews() {
//        backgroundColor = UIColor.white
//        addSubview(thumbnailImageView)
//        addSubview(separaterView)
//        addSubview(profileImageView)
//        addSubview(titleLabel)
//        addSubview(subTitleTextView)
//
//        //thumbnail constraint
//        NSLayoutConstraint.activate([
//            thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
//            thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            thumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
//            thumbnailImageView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: -8)
//            ])
//
//        //profile image constraint
//        NSLayoutConstraint.activate([
//            profileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
//            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            profileImageView.widthAnchor.constraint(equalToConstant: 44),
//            profileImageView.heightAnchor.constraint(equalToConstant: 44)
//            ])
//
//        // title constraints
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
//            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 50),
//            titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 0),
//            titleLabel.bottomAnchor.constraint(equalTo: subTitleTextView.topAnchor, constant: 8)
//            ])
//
//        // subtitle constraints
//        NSLayoutConstraint.activate([
//            subTitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
//            subTitleTextView.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 50),
//            subTitleTextView.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 0),
//            subTitleTextView.bottomAnchor.constraint(equalTo: separaterView.topAnchor, constant: -20)
//            ])
//
//        // separator constraints
//        NSLayoutConstraint.activate([
//            separaterView.topAnchor.constraint(equalTo: subTitleTextView.bottomAnchor),
//            separaterView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            separaterView.heightAnchor.constraint(equalToConstant: 1),
//            separaterView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            separaterView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//            ])
//    }
//
//    func downloadImage(imageType: String, urlString: String) {
//        if let url = URL(string: urlString) {
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//                guard let data = data else { return }
//
//                DispatchQueue.main.async() {
//                    if imageType == "videoThumbnail" {
//                        self.thumbnailImageView.image = UIImage(data: data)
//                    } else if imageType == "profile_image" {
//                        self.profileImageView.image = UIImage(data: data)
//                    }
//                    self.delegate?.updateUI()
//                }
//                }.resume()
//        }
//    }
//
//}
//





//===============================
// ======== backup 4/9/18 =======

////  VideoCell.swift
////  AcuDragon
////
////  Created by Emiko Clark on 1/23/18.
////  Copyright © 2018 Emiko Clark. All rights reserved.
////
//
//import UIKit
//
////protocol reloadDataDelegate {
////    func updateUI()
////}
//
//class VideoCell: BaseCell {
//
//    var videoItem = Items()
//    var delegate: reloadDataDelegate?
//
//    enum MyKeys: String, CodingKey {
//        case thumbnail = "thumbnails"
//        case urlString = "url"
//    }
//
//    //    var video: Video? {
//    //        didSet {
//    //
//    //            dump(videoItem)
//    ////            let videoItem = Items()
//    //
//    ////            if let profile_image_name  =  videoItem.snippet {
//    ////                downloadImage(imageType: "profile_image_name", urlString: profile_image_name)
//    ////            }
//    //
//    //            if let thumbnailUrlString = videoItem.snippet?.thumbnails?.high?.url {
//    //                downloadImage(imageType: "videoThumbnail", urlString: thumbnailUrlString)
//    //            }
//    //
//    //            titleLabel.text = videoItem.snippet?.title
//    //
//    //            if let channelSubtitle = videoItem.snippet?.description {
//    //                subTitleTextView.text = channelSubtitle
//    //            }
//    //
//    //            // estimate height for titleLabelText
//    //            if let title = videoItem.snippet?.title {
//    //                let size = CGSize(width: frame.size.width - 16 - 44 - 8 - 16, height: 1000)
//    //                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//    //                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)] , context: nil)
//    //
//    //                if estimatedRect.size.height > 21 {
//    //                    titleLabelHeightConstraint?.constant = 44
//    //                } else {
//    //                    titleLabelHeightConstraint?.constant = 21
//    //                }
//    //                print("estimatedRect:", estimatedRect)
//    //                titleLabel.text = title
//    //            }
//    //
//    //            if let channelDescription = videoItem.snippet?.description {
//    //                let size = CGSize(width: frame.size.width - 16 - 44 - 8 - 16, height: 1000)
//    //                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//    //                let estimatedRect = NSString(string: channelDescription).boundingRect(with: size, options: options, attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)] , context: nil)
//    //
//    //                if estimatedRect.size.height > 21 {
//    //                    titleLabelHeightConstraint?.constant = 44
//    //                } else {
//    //                    titleLabelHeightConstraint?.constant = 21
//    //                }
//    //                print("estimatedRect:", estimatedRect)
//    //                subTitleTextView.text = channelDescription
//    //            }
//    //
//    //            // estimate height for subTitle
//    //            // estimate height for VideoCell (video+16+titleLabelHeight+8+subTitleLabelHeight+16)
//    //
//    //            if let thumbnailImageUrlString = videoItem.snippet?.thumbnails?.high?.url {
//    //                downloadImage(imageType: "thumbnail", urlString: thumbnailImageUrlString)
//    //            }
//    //        }
//    //    }
//
//    var profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.layer.cornerRadius = 22
//        imageView.layer.masksToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.image = #imageLiteral(resourceName: "channelDragonPlaceholder")
//        return imageView
//    }()
//
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.sizeToFit()
//        return label
//    }()
//
//    let subTitleTextView: UITextView = {
//        let textview = UITextView()
//        textview.translatesAutoresizingMaskIntoConstraints = false
//        textview.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
//        textview.textColor = UIColor.lightGray
//        return textview
//    }()
//
//    let separaterView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 230/255)
//        return view
//    }()
//
//    let thumbnailImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = UIColor.cyan
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.image = UIImage(named: "dragonPlaceholder.jpg")
//        return imageView
//    }()
//
//    var titleLabelHeightConstraint: NSLayoutConstraint?
//
//    override func setupViews() {
//        backgroundColor = UIColor.white
//        addSubview(thumbnailImageView)
//        addSubview(separaterView)
//        addSubview(profileImageView)
//        addSubview(titleLabel)
//        addSubview(subTitleTextView)
//
//        // constraints
//        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
//        addConstraintsWithFormat(format: "H:|-16-[v0(44)]-[v1]-16-|", views: profileImageView, titleLabel)
//        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, profileImageView, separaterView)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: separaterView)
//
//        // titleLabel constraints
//        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
//        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left , relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
//        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right , relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
//
//        titleLabelHeightConstraint = (NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
//        addConstraint(titleLabelHeightConstraint!)
//
//        // subTitleTextView constraints
//        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
//        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left , relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
//        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right , relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: subTitleTextView , attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
//    }
//
//    //    func downloadImage(imageType: String, urlString: String) {
//    //        if let url = URL(string: urlString) {
//    //            URLSession.shared.dataTask(with: url) { (data, response, error) in
//    //                if error != nil {
//    //                    print(error!)
//    //                    return
//    //                }
//    //                guard let data = data else { return }
//    //
//    //                DispatchQueue.main.async() {
//    //                    if imageType == "videoThumbnail" {
//    //                        self.thumbnailImageView.image = UIImage(data: data)
//    //                    } else if imageType == "profile_image" {
//    //                        self.profileImageView.image = UIImage(data: data)
//    //                    }
//    //                    self.delegate?.updateUI()
//    //                }
//    //            }.resume()
//    //        }
//    //    }
//
//}



//============================================================
//== backup menubar w/ all features
//
//  MenuBar.swift
//  AcuDragon
//
//  Created by Emiko Clark on 1/23/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//
//
//import UIKit
//
//class BaseCell : UICollectionViewCell {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//    func setupViews() {
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
//class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    
//    let cellId = "cellId"
//    let menuImages = ["home","trending","subscriptions","account"]
//    let menuTitle = ["Home","Trending","Subscription","Account"]
//
//    lazy var collectionview : UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
//        cv.delegate = self
//        cv.dataSource = self
//        return cv
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        collectionview.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
//        addSubview(collectionview)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionview)
//        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionview)
//
//        // make the 1st icon selected whenever app starts
//        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
//        collectionview.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellSize = CGSize(width: frame.size.width/4, height: frame.size.height)
//        return cellSize
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
//        cell.menuImageView.image = UIImage(named: menuImages[indexPath.row])?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//        cell.tintColor = UIColor.rgb(red: 91, green: 13, blue: 14)
//        return cell
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class MenuCell : BaseCell {
//
//    override func setupViews() {
//        super.setupViews()
//
//        addSubview(menuImageView)
//        menuImageView.addConstraintsWithFormat(format: "H:[v0(40)]", views: menuImageView)
//        menuImageView.addConstraintsWithFormat(format: "V:[v0(40)]", views: menuImageView)
//
//        addConstraint(NSLayoutConstraint(item: menuImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX , multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: menuImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY , multiplier: 1, constant: 0))
//    }
//
//    override var isSelected: Bool {
//        didSet {
//            menuImageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
//        }
//    }
//
//    override var isHighlighted: Bool {
//        didSet {
//            menuImageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
//        }
//    }
//
//    let menuImageView : UIImageView = {
//        let iv = UIImageView()
//        // iv.image = UIImage(named: "dragon.png")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
//        iv.contentMode = .scaleAspectFit
//        return iv
//    }()
//    
//
//}
//
//
//



//=================================================
//== backup HomeVC full menuBar ============
//
//  ViewController.swift
//  AcuDragon
//
//  Created by Emiko Clark on 1/22/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

//import UIKit
//
//class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    let vcell = VideoCell()
//
//    let menuBar: MenuBar = {
//        let mb = MenuBar()
//        return mb
//    }()
//
//    var activityIndicator: UIActivityIndicatorView!
//    let apiClient = ApiClient()
//    let pageNum = 0
//
//    // MARK:- View Methods
//    override func viewWillAppear(_ animated: Bool) {
//        initializeVideoModelForEmptyState()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        apiClient.delegate = self
//
//        startActivityIndicator()
//        setupViewController()
//        self.apiClient.fetchVideos(pageNum: pageNum)
//    }
//
//    // MARK:- Setup/Initialization Methods
//    func initializeVideoModelForEmptyState() {
//
//        // create empty video array for empty state
//        let eva = Video()
//        eva.etag = " "
//        eva.items = [Items]()
//
//        var itemsArr = Items()
//        itemsArr.etag = " "
//        itemsArr.channelTitle = " "
//        itemsArr.id = Id()
//        itemsArr.id?.playlistId = " "
//
//        var snippet = Snippet()
//        snippet.channelId = " "
//        snippet.title = " "
//        snippet.description = " "
//
//        var videoThumbnails = VideoThumbnails()
//        videoThumbnails.high = Thumbnails()
//
//        videoThumbnails.high?.url = " "
//        videoThumbnails.high?.height = 0
//        videoThumbnails.high?.width = 0
//
//        snippet.thumbnails = videoThumbnails
//        itemsArr.snippet = snippet
//        eva.items?.append(itemsArr)
//        ApiClient.videosArray = eva
//    }
//
//    func startActivityIndicator() {
//        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
//        self.activityIndicator.color = .blue
//        self.activityIndicator.center = view.center
//        self.activityIndicator.hidesWhenStopped = false
//        self.activityIndicator.startAnimating()
//        view.addSubview(self.activityIndicator)
//    }
//
//    func setupViewController() {
//        // Register cell
//        self.collectionView!.register(VideoCell.self, forCellWithReuseIdentifier: "cellid")
//
//        // adjust collectionview and scrollview to begin below menubar
//        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
//        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
//
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
//
//        let navTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
//        navTitleLabel.text = "Home"
//        navTitleLabel.font = UIFont.systemFont(ofSize: 20)
//        navTitleLabel.textColor = UIColor.white
//        navigationItem.titleView = navTitleLabel
//        collectionView?.backgroundColor = UIColor.white
//
//        // add search to navbar
//        let searchIcon = UIImage(named:"searchIcon")?.withRenderingMode(.alwaysOriginal)
//        let searchBarButtonItem = UIBarButtonItem(image: searchIcon, style: .plain, target: self, action: #selector(handleSearch))
//
//        // add more to navbar
//        let moreIcon = UIImage(named:"moreIcon")?.withRenderingMode(.alwaysOriginal)
//        let moreBarButtonItem = UIBarButtonItem(image: moreIcon, style: .plain, target: self, action: #selector(handleMore))
//        navigationItem.rightBarButtonItems = [ moreBarButtonItem, searchBarButtonItem ]
//
//        setupMenuBar()
//    }
//
//    private func setupMenuBar() {
//        view.addSubview(menuBar)
//        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
//        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
//    }
//
//    // MARK:- CollectionView Delegate Methods
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return (ApiClient.videosArray.items?.count)!
//    }
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! VideoCell
//        let videoInfo = ApiClient.videosArray.items![indexPath.row]
//        //        cell.videoItem = ApiClient.videosArray.items![indexPath.row]
//
//        cell.subTitleTextView.text =  videoInfo.channelTitle != nil ?  videoInfo.channelTitle : "AcuDragon Wellness System"
//        cell.subTitleTextView.text =  videoInfo.snippet?.description != nil ?  videoInfo.snippet?.description : "AcuDragon Wellness System"
//
//        apiClient.downloadImage(urlString: (videoInfo.snippet?.thumbnails?.high?.url!)!) { (thumbnailImage) in
//            cell.thumbnailImageView.image = thumbnailImage
//        }
//
//        cell.profileImageView.image = #imageLiteral(resourceName: "dragon")
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        //     FIX:    calculate all object height+ vertical padding
//        //        let cell = videos[indexPath.row]
//        //        let height = (view.frame.width - 16 - 16) * 9 / 16
//
//        let height = (view.frame.width - 16 - 16) * 9 / 16
//        return CGSize(width: view.frame.width, height: height + 16 + 68)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    // MARK:- MenuBar Methods
//    @objc func handleSearch() {
//        print("123")
//    }
//
//    @objc func handleMore() {
//        print("234")
//    }
//
//}
//
//// MARK:- Extensions
//extension HomeController : reloadDataDelegate {
//    func updateUI() {
//        self.activityIndicator.stopAnimating()
//        self.activityIndicator.isHidden = true
//        self.collectionView?.reloadData()
//    }
//}
//

