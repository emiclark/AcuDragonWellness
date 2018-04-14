//
//  VideoCell.swift
//  AcuDragon
//
//  Created by Emiko Clark on 1/23/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    var videoItem = Items()
    var delegate: reloadDataDelegate?
    
    enum MyKeys: String, CodingKey {
        case thumbnail = "thumbnails"
        case urlString = "url"
    }
    

//     var video: Video? {
//         didSet {
            
//             dump(videoItem)
//             let videoItemSnippet = self.videoItem.snippet
            
// //            if let profile_image_name  =  videoItem.snippet.. {
// //                downloadImage(imageType: "profile_image_name", urlString: profile_image_name)
// ////            }
            
//             if let thumbnailUrlString = videoItemSnippet?.thumbnails?.high?.url {
//                 downloadImage(imageType: "videoThumbnail", urlString: thumbnailUrlString)
//             }

//             titleLabel.text = videoItemSnippet?.title

//             if let channelSubtitle = videoItemSnippet?.description {
//                 subTitleTextView.text = channelSubtitle
//             }

//             // estimate height for titleLabelText
//             if let title = videoItemSnippet?.title {
//                 let size = CGSize(width: frame.size.width - 16 - 44 - 8 - 16, height: 1000)
//                 let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//                 let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)] , context: nil)

//                 if estimatedRect.size.height > 21 {
//                     titleLabelHeightConstraint?.constant = 44
//                 } else {
//                     titleLabelHeightConstraint?.constant = 21
//                 }
//                 print("estimatedRect:", estimatedRect)
//                 titleLabel.text = title
//             }
            
//             if let channelDescription = videoItemSnippet?.description {
//                 let size = CGSize(width: frame.size.width - 16 - 44 - 8 - 16, height: 1000)
//                 let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//                 let estimatedRect = NSString(string: channelDescription).boundingRect(with: size, options: options, attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)] , context: nil)
                
//                 if estimatedRect.size.height > 21 {
//                     titleLabelHeightConstraint?.constant = 44
//                 } else {
//                     titleLabelHeightConstraint?.constant = 21
//                 }
//                 print("estimatedRect:", estimatedRect)
//                 subTitleTextView.text = channelDescription
//             }

//             // estimate height for subTitle
//             // estimate height for VideoCell (video+16+titleLabelHeight+8+subTitleLabelHeight+16)
            
//             if let thumbnailImageUrlString = videoItemSnippet?.thumbnails?.high?.url {
//                 downloadImage(imageType: "thumbnail", urlString: thumbnailImageUrlString)
//             }
//         }
//     }
    
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

