//
//  Video.swift
//  AcuDragon
//
//  Created by Emiko Clark on 1/25/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

class Video: Decodable {
    var items: [Items]?
    var etag: String?
}

struct Items: Decodable {
    var etag: String?
    var id: Id?
    var snippet: Snippet?
    var channelTitle: String?
}

struct Id: Decodable {
    var playlistId: String?
}

struct Snippet: Decodable {
    var channelId: String?
    var title: String?
    var description: String?
    var thumbnails: VideoThumbnails?
}

struct VideoThumbnails: Decodable {
    var medium: Thumbnails?
    var high: Thumbnails?
}

struct Thumbnails: Decodable {
    var url: String?
    var width: Int?
    var height: Int?
}



//class Channel: NSObject, Decodable {
//    var name: String?
//    var profile_image_name: String?
//}
//
//struct ResourceID: Decodable {
//    let kind: String?
//    let videoId: String?
//}
//
//class Thumbnail: Decodable {
//    var url: String?
//    var width: Int?
//    var height: Int?
//}
//
//class Video:  NSObject, Decodable {
//    var thumbnail: [Thumbnail]?
//    var channel: Channel?
//    var title: String?
//    var descrip: String?
//}

// backup =================

//import UIKit
//
//class Channel: NSObject, Decodable {
//    var name: String?
//    var profile_image_name: String?
//}
//
//struct ResourceID: Decodable {
//    let kind: String?
//    let videoId: String?
//}
//
//class Thumbnail: Decodable {
//    var url: String?
//    var width: Int?
//    var height: Int?
//}
//
//class Video:  NSObject, Decodable {
//    var thumbnail: [Thumbnail]?
//    var channel: Channel?
//    var title: String?
//    var descrip: String?
//    //    var resourceId: ResourceID?
//
//    init(jsonDictionary: [String:Any]) {
//        guard
//            let itemsArr = jsonDictionary["items"] as? [String: Any],
//            let snippets = itemsArr["snippets"] as? [String: Any],
//            let channelId = snippets["channelId"] as? Channel,
//            let title = snippets["title"] as? String,
//            let descriptionText = snippets["description"] as? String,
//            let thumbnail = snippets["thumbnail"] as? [Thumbnail]
//            else { print("video object unwrapping error"); return }
//
//        self.thumbnail = thumbnail
//        self.channel = channelId
//        self.title = title
//        self.descrip = descriptionText
//
//    }
//}

////====== backup ======
////
////  Video.swift
////  AcuDragon
////
////  Created by Emiko Clark on 1/25/18.
////  Copyright © 2018 Emiko Clark. All rights reserved.
////
//
//import UIKit
//
//class Channel: NSObject, Decodable {
//    var name: String?
//    var profile_image_name: String?
//}
//
//class Video:  NSObject, Decodable {
//    var thumbnail_image_name: String?
//    var channel: Channel?
//    var title: String?
//    var subTitle: String?
//}

//class Thumbnails: Decodable {
//    var thumbnailSize: [ThumbnailSize]?
//}
