//
//  Constants.swift
//  AcuDragon
//
//  Created by Emiko Clark on 4/6/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let baseUrlString = "https://www.googleapis.com/youtube/v3/search?key="
    static let lightGreyColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 230/255)
    
}


/* ec channel response ============
 https://www.googleapis.com/youtube/v3/search?key=AIzaSyDmqaPH8yJO7uMfTUXz9AKxP5zdb79ym0Q&channelId=UCD5kT8GTKnbYl9WxgnLM0aA&part=snippet&maxResults=20
 
 // returns playlist for ec channel 50 items
 https://www.googleapis.com/youtube/v3/playlistItems?playlistId=UUD5kT8GTKnbYl9WxgnLM0aA&key=AIzaSyCz7ChsZALe88gbZuQyexQY82oQ1de6qZU&part=snippet&maxResults=50
 
 ==================================
 */
