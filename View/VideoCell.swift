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
    

     var videoItemSnippet: Snippet? {
         didSet {
            
            if let thumbnailUrlString = videoItemSnippet?.thumbnails?.high?.url {
                 downloadImage(imageType: "videoThumbnail", urlString: thumbnailUrlString)
            }

            if videoItemSnippet?.title  != nil {
                titleLabel.text = videoItemSnippet?.title
            } else {
                titleLabel.text = " "
            }

            if videoItemSnippet?.description != nil {
                 subTitleTextView.text = videoItemSnippet?.description
            } else {
                subTitleTextView.text = " "
            }

//            if let title = videoItemSnippet?.title {
//                 titleLabel.text = title
//            }
            
//            if let channelDescription = videoItemSnippet?.description {
//                 subTitleTextView.text = channelDescription
//            }
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
        imageView.image = #imageLiteral(resourceName: "dragonPlaceholder")
        return imageView
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "dragon")
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
    
    var stackText = UIStackView()
    var stackImgText = UIStackView()
    
    override func setupViews() {
        backgroundColor = UIColor.white
        addSubview(thumbnailImageView)
        addSubview(separaterView)
        addSubview(profileImageView)
        addSubview(stackText)

        // add title and subtitle to stackText
        stackText.addArrangedSubview(titleLabel)
        stackText.addArrangedSubview(subTitleTextView)
        stackText.translatesAutoresizingMaskIntoConstraints = false
        stackText.axis = .vertical
        stackText.distribution = .fill
        stackText.spacing = 4
        
        // stackText constraints
        stackText.isLayoutMarginsRelativeArrangement = true
        stackText.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackText.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 4).isActive = true
        stackText.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12).isActive = true
        stackText.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 0).isActive = true
        stackText.bottomAnchor.constraint(equalTo: separaterView.topAnchor, constant: -16).isActive = true
        
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
        
        // separator constraints
        NSLayoutConstraint.activate([
            separaterView.topAnchor.constraint(equalTo: stackText.bottomAnchor, constant: -12),
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

