//
//  VideoCell.swift
//  AcuDragon
//
//  Created by Emiko Clark on 1/23/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

//protocol reloadDataDelegate {
//    func updateUI()
//}

class VideoCell: BaseCell {
    
    var videoItem = Items()
    var delegate: reloadDataDelegate?
    
    enum MyKeys: String, CodingKey {
        case thumbnail = "thumbnails"
        case urlString = "url"
    }
    
    var video: Video? {
        didSet {
            
            dump(videoItem)
            let videoItemSnippet = self.videoItem.snippet
            
//            if let profile_image_name  =  videoItem.snippet.. {
//                downloadImage(imageType: "profile_image_name", urlString: profile_image_name)
////            }
            
            if let thumbnailUrlString = videoItemSnippet?.thumbnails?.high?.url {
                downloadImage(imageType: "videoThumbnail", urlString: thumbnailUrlString)
            }

            titleLabel.text = videoItemSnippet?.title

            if let channelSubtitle = videoItemSnippet?.description {
                subTitleTextView.text = channelSubtitle
            }

            // estimate height for titleLabelText
            if let title = videoItemSnippet?.title {
                let size = CGSize(width: frame.size.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)] , context: nil)

                if estimatedRect.size.height > 21 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 21
                }
                print("estimatedRect:", estimatedRect)
                titleLabel.text = title
            }
            
            if let channelDescription = videoItemSnippet?.description {
                let size = CGSize(width: frame.size.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: channelDescription).boundingRect(with: size, options: options, attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)] , context: nil)
                
                if estimatedRect.size.height > 21 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 21
                }
                print("estimatedRect:", estimatedRect)
                subTitleTextView.text = channelDescription
            }

            // estimate height for subTitle
            // estimate height for VideoCell (video+16+titleLabelHeight+8+subTitleLabelHeight+16)
            
            if let thumbnailImageUrlString = videoItemSnippet?.thumbnails?.high?.url {
                downloadImage(imageType: "thumbnail", urlString: thumbnailImageUrlString)
            }
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor( red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0 ).cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "dragon")
        return imageView
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "channelDragonPlaceholder")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.frame.size.height = 20
        label.backgroundColor = UIColor.yellow
        label.sizeToFit()
        return label
    }()
    
    let subTitleTextView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.cyan
        label.sizeToFit()
        return label
    }()
    
    let separaterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 230/255)
        return view
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    var subTitleLabelHeightConstraint: NSLayoutConstraint?

    override func setupViews() {
        backgroundColor = UIColor.white
        addSubview(thumbnailImageView)
        addSubview(separaterView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)

        //thumbnail constraint
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            thumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
            thumbnailImageView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: -8)
        ])
        
        //profile image constraint
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 44),
            profileImageView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // title constraints
         NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: subTitleTextView.topAnchor, constant: 8)
//            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -20)
        ])
        
        // subtitle constraints
        NSLayoutConstraint.activate([
            subTitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleTextView.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 50),
            subTitleTextView.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 0),
            subTitleTextView.bottomAnchor.constraint(equalTo: separaterView.topAnchor, constant: -20)
        ])

        // separator constraints
        NSLayoutConstraint.activate([
            separaterView.topAnchor.constraint(equalTo: subTitleTextView.bottomAnchor),
            separaterView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separaterView.heightAnchor.constraint(equalToConstant: 1),
            separaterView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separaterView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func downloadImage(imageType: String, urlString: String) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                guard let data = data else { return }
                
                DispatchQueue.main.async() {
                    if imageType == "videoThumbnail" {
                        self.thumbnailImageView.image = UIImage(data: data)
                    } else if imageType == "profile_image" {
                        self.profileImageView.image = UIImage(data: data)
                    }
                    self.delegate?.updateUI()
                }
            }.resume()
        }
    }
    
}
///========== cell not showing up bakup
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
//    var video: Video? {
//        didSet {
//
//            dump(videoItem)
//            let videoItemSnippet = self.videoItem.snippet
//
//            //            if let profile_image_name  =  videoItem.snippet.. {
//            //                downloadImage(imageType: "profile_image_name", urlString: profile_image_name)
//            ////            }
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
//            // estimate height for titleLabelText
//            if let title = videoItemSnippet?.title {
//                let size = CGSize(width: frame.size.width - 16 - 44 - 8 - 16, height: 1000)
//                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)] , context: nil)
//
//                if estimatedRect.size.height > 21 {
//                    titleLabelHeightConstraint?.constant = 44
//                } else {
//                    titleLabelHeightConstraint?.constant = 21
//                }
//                print("estimatedRect:", estimatedRect)
//                titleLabel.text = title
//            }
//
//            if let channelDescription = videoItemSnippet?.description {
//                let size = CGSize(width: frame.size.width - 16 - 44 - 8 - 16, height: 1000)
//                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//                let estimatedRect = NSString(string: channelDescription).boundingRect(with: size, options: options, attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)] , context: nil)
//
//                if estimatedRect.size.height > 21 {
//                    titleLabelHeightConstraint?.constant = 44
//                } else {
//                    titleLabelHeightConstraint?.constant = 21
//                }
//                print("estimatedRect:", estimatedRect)
//                subTitleTextView.text = channelDescription
//            }
//
//            // estimate height for subTitle
//            // estimate height for VideoCell (video+16+titleLabelHeight+8+subTitleLabelHeight+16)
//
//            if let thumbnailImageUrlString = videoItemSnippet?.thumbnails?.high?.url {
//                downloadImage(imageType: "thumbnail", urlString: thumbnailImageUrlString)
//            }
//        }
//    }
//
//    var profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.layer.cornerRadius = 22
//        imageView.layer.masksToBounds = true
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = #imageLiteral(resourceName: "channelDragonPlaceholder")
//        return imageView
//    }()
//
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.sizeToFit()
//        return label
//    }()
//
//    let subTitleTextView: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.backgroundColor = UIColor.cyan
//        label.sizeToFit()
//        return label
//    }()
//
//
//    //    let subTitleTextView: UITextView = {
//    //        let textview = UITextView()
//    //        textview.translatesAutoresizingMaskIntoConstraints = false
//    //        textview.contentMode = .top
//    //        textview.backgroundColor = UIColor.cyan
//    //        textview.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
//    //        textview.font = UIFont.systemFont(ofSize: 16)
//    //        textview.textColor = UIColor.darkGray
//    //        return textview
//    //    }()
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
//        imageView.layer.cornerRadius = 8
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = UIColor( red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0 ).cgColor
//        imageView.clipsToBounds = true
//        imageView.image = #imageLiteral(resourceName: "dragon")
//        return imageView
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
//        //        // constraints
//        //        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
//        //        addConstraintsWithFormat(format: "H:|-16-[v0(44)]-[v1]-16-|", views: profileImageView, titleLabel)
//        //        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, profileImageView, separaterView)
//        //        addConstraintsWithFormat(format: "H:|[v0]|", views: separaterView)
//
//        //thumbnail constraint1
//        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
//        thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
//        thumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
//
//        //profile image constraint1
//        profileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8)
//        profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
//        profileImageView.widthAnchor.constraint(equalToConstant: 44)
//        profileImageView.heightAnchor.constraint(equalToConstant: 44)
//
//        // title constraints1
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
//            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 52),
//            titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 0),
//            //            titleLabel.bottomAnchor.constraint(equalTo: subTitleTextView.topAnchor, constant:0),
//            //            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 10)
//            ])
//        // subtitle constraints
//        NSLayoutConstraint.activate([
//            subTitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
//            subTitleTextView.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 50),
//            subTitleTextView.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
//            subTitleTextView.bottomAnchor.constraint(equalTo: separaterView.topAnchor, constant: -20)
//            ])
//
//        // separator constraints
//        NSLayoutConstraint.activate([
//            separaterView.topAnchor.constraint(equalTo: subTitleTextView.bottomAnchor, constant: -25),
//            separaterView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
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
////======= backup v1 ======
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
//    var video: Video? {
//        didSet {
//
//            if let thumbnail_image_name = video?.thumbnail_image_name {
//                downloadImage(imageType: "thumbnail_image_name", urlString: thumbnail_image_name)
//            }
//
//            if let profile_image_name  = video?.channel?.profile_image_name {
//                downloadImage(imageType: "profile_image_name", urlString: profile_image_name)
//            }
//
//            titleLabel.text = video?.title
//
//            if let channelSubtitle = video?.subTitle, ((video?.channel?.name) != nil) {
//                let subtitleText = "\(String(describing: (video?.channel?.name)!)) - \(channelSubtitle)"
//                subTitleTextView.text = subtitleText
//            }
//
//            // estimate height for titleLabelText
//            if let title = video?.title {
//                let size = CGSize(width: frame.size.width - 16 - 44 - 8 - 16, height: 1000)
//                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)] , context: nil)
//
//                if estimatedRect.size.height > 21 {
//                    titleLabelHeightConstraint?.constant = 44
//                } else {
//                    titleLabelHeightConstraint?.constant = 21
//                }
//                print("estimatedRect:", estimatedRect)
//            }
//
//            // estimate height for subTitle
//            // estimate height for VideoCell (video+16+titleLabelHeight+8+subTitleLabelHeight+16)
//        }
//    }
//
//    var profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.layer.cornerRadius = 22
//        imageView.layer.masksToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.image = #imageLiteral(resourceName: "dragon")
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
//        imageView.image = #imageLiteral(resourceName: "dragon")
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
//                    if imageType == "thumbnail_image_name" {
//                        self.thumbnailImageView.image = UIImage(data: data)
//                    } else if imageType == "profile_image_name" {
//                        self.profileImageView.image = UIImage(data: data)
//                    }
//
//                }
//                }.resume()
//        }
//    }
//
//}

//=================== backup viewDidLoad 2/24/18 ====================
//var video: Video? {
//    didSet {
//
//        //            guard let thumbnails: [Thumbnails] = video?.thumbnails else { return }
//
//
//        guard let thumbnails = video?.thumbnails, let thumbnailUrlString = thumbnails["default"] else { return }
//
//
//        //                if let thumbnailSize = thumbnails["standard"] { return }
//        // FIX urlString - extract thumbnailImageString = "/"Ja4BwMEbfqE"
//        // "url": "https:\/\/i.ytimg.com\/vi\/Ja4BwMEbfqE\/maxresdefault.jpg"
//        // "url": "https://i.ytimg.com/vi/ + thumbnailImageString + /maxresdefault.jpg",
//
//        //                let tempURL = NSURL(string: "https:\/\/i.ytimg.com\/vi\/Ja4BwMEbfqE\/maxresdefault.jpg")
//
//
//        //                guard let thumbnailSize = thumbnailSize["default"] else { return }
//        //                downloadImage(imageType: thumbnailSize, urlString: thumbailSizeURLString)
//        //            }
//
//        if let profile_image_name  = video?.channel?.profile_image_name {
//            downloadImage(imageType: "profile_image_name", urlString: profile_image_name)
//        }
//
//        titleLabel.text = video?.title
//
//        if let channelSubtitle = video?.videoDescription, ((video?.channel?.name) != nil) {
//            let subtitleText = "\(String(describing: (video?.channel?.name)!)) - \(channelSubtitle)"
//            subTitleTextView.text = subtitleText
//        }
//
//        // estimate height for titleLabelText
//        if let title = video?.title {
//            let size = CGSize(width: frame.size.width - 16 - 44 - 8 - 16, height: 1000)
//            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//            let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)] , context: nil)
//
//            if estimatedRect.size.height > 21 {
//                titleLabelHeightConstraint?.constant = 44
//            } else {
//                titleLabelHeightConstraint?.constant = 21
//            }
//            print("estimatedRect:", estimatedRect)
//        }
//
//        // estimate height for subTitle
//        // estimate height for VideoCell (video+16+titleLabelHeight+8+subTitleLabelHeight+16)
//    }
//}

