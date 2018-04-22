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

            // for testing purpose =====================
            titleLabel.text = "AcuDragon Wellness System AcuDragon Wellness System. AcuDragon Wellness System AcuDragon Wellness System"
            subTitleTextView.text = "AcuDragon - AcuDragon Wellness System AcuDragon Wellness System. AcuDragon Wellness System AcuDragon Wellness System"
            // for testing purpose =====================
            
//            if videoItemSnippet?.title  != nil {
//                titleLabel.text = videoItemSnippet?.title
//            } else {
//                titleLabel.text = "AcuDragon Wellness System"
//            }
//
//            if videoItemSnippet?.description != "" {
//                 subTitleTextView.text = videoItemSnippet?.description
//            } else {
//                subTitleTextView.text = "AcuDragon"
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
        label.backgroundColor = UIColor.yellow
//        label.sizeToFit()
        return label
    }()
    
    let subTitleTextView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.cyan
//        label.sizeToFit()
        return label
    }()
    
    let separaterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor  = .red
//        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 230/255)
        return view
    }()
    
    var stackText: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func setupViews() {
        setNeedsLayout()
        layoutIfNeeded()
        
        backgroundColor = UIColor.white
        
        // create stack and add title and subtitle
        stackText.addArrangedSubview(titleLabel)
        stackText.addArrangedSubview(subTitleTextView)
        
        contentView.addSubview(stackText)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(profileImageView)
        contentView.addSubview(separaterView)
        
        // configure stackText
        stackText.axis = .vertical
        stackText.alignment = .fill
        stackText.distribution = .fillProportionally
        stackText.isLayoutMarginsRelativeArrangement = true
        
        // contstrain thumbnail
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            // (x * 9/16) creates optimal frame for videos
            thumbnailImageView.heightAnchor.constraint(equalToConstant: ((self.frame.width - 16 - 16) * 9 / 16))
        ])
        
        // contstrain profileImageView
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 44),
            profileImageView.heightAnchor.constraint(equalToConstant: 44)
        ])

        
        // contstrain stackText - will contain titleLabel and subTitleTextView
        NSLayoutConstraint.activate([
            stackText.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 16),
            stackText.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 4),
            stackText.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
             stackText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // constrain separaterView
        separaterView.heightAnchor.constraint(equalToConstant: 3)
        
        NSLayoutConstraint.activate([
            separaterView.topAnchor.constraint(equalTo: stackText.bottomAnchor),
            separaterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separaterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
//        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        print("size:,\(size)")

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

extension UIView {
    
    func anchorSetSize(height: CGFloat?, width: CGFloat?) {

        // sets height and width of view
        if let height = height {
            heightAnchor.constraint(equalToConstant: height)
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width)
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero) {
        
//        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
    }
}

//============== backup constraints =====

//        // contstrain titleLabel
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: testView.topAnchor),
//            titleLabel.leadingAnchor.constraint(equalTo: testView.leadingAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: testView.trailingAnchor)
//        ])
//
//        // contstrain subTitleTextView
//        NSLayoutConstraint.activate([
//            subTitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
//            subTitleTextView.leadingAnchor.constraint(equalTo: testView.leadingAnchor),
//            subTitleTextView.trailingAnchor.constraint(equalTo: testView.trailingAnchor),
//            subTitleTextView.bottomAnchor.constraint(equalTo: testView.bottomAnchor)
//        ])

//=============================



//        //profile image constraint
//        profileImageView.anchorSetSize(height: 44, width: 44)
//        profileImageView.anchor(top: thumbnailImageView.bottomAnchor, leading: thumbnailImageView.leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
//


// titleLabel.anchor(top: stackText.topAnchor, leading: stackText.leadingAnchor, trailing: stackText.trailingAnchor, bottom: subTitleTextView.topAnchor)

// subTitleTextView.anchor(top: titleLabel.bottomAnchor, leading: stackText.leadingAnchor, trailing: stackText.trailingAnchor, bottom: stackText.bottomAnchor)

// separaterView.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: nil)

// stackText.anchor(top: thumbnailImageView.bottomAnchor, leading: profileImageView.trailingAnchor, trailing: thumbnailImageView.trailingAnchor, bottom: nil, padding: .init(top: 10, left: 16, bottom: 0, right: 0))
