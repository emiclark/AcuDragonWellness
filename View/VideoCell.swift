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
//            let videoItem = Items()
            
//            if let profile_image_name  =  videoItem.snippet {
//                downloadImage(imageType: "profile_image_name", urlString: profile_image_name)
//            }
            
            if let thumbnailUrlString = videoItem.snippet?.thumbnails?.high?.url {
                downloadImage(imageType: "videoThumbnail", urlString: thumbnailUrlString)
            }

            titleLabel.text = videoItem.snippet?.title

            if let channelSubtitle = videoItem.snippet?.description {
                subTitleTextView.text = channelSubtitle
            }

            // estimate height for titleLabelText
            if let title = videoItem.snippet?.title {
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
            
            if let channelDescription = videoItem.snippet?.description {
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
            
            if let thumbnailImageUrlString = videoItem.snippet?.thumbnails?.high?.url {
                downloadImage(imageType: "thumbnail", urlString: thumbnailImageUrlString)
            }
        }
    }
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "channelDragonPlaceholder")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    let subTitleTextView: UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textview.textColor = UIColor.lightGray
        return textview
    }()
    
    let separaterView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 230/255)
        return view
    }()
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.cyan
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "dragonPlaceholder.jpg")
        return imageView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        backgroundColor = UIColor.white
        addSubview(thumbnailImageView)
        addSubview(separaterView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        // constraints
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]-[v1]-16-|", views: profileImageView, titleLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, profileImageView, separaterView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separaterView)
        
        // titleLabel constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left , relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right , relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        titleLabelHeightConstraint = (NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
        addConstraint(titleLabelHeightConstraint!)
        
        // subTitleTextView constraints
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left , relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right , relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subTitleTextView , attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
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

