//
//  Const.swift
//  Flickr-Search
//
//  Created by Salma Ashour on 4/8/17.
//  Copyright © 2017 Salma. All rights reserved.
//

import Foundation
import Alamofire
import BRYXBanner


class Utils{

enum Const{
    
    static let api_key = "a3482b0c44f327ad0a6a5245937e69b8"
    static let baseURL = "https://api.flickr.com/services/rest/"
    static let flickrSerachMethod = "flickr.photos.search"
    static let userPhotosMethod = "flickr.people.getPhotos"
    static let pre_page = 20
    static let format = "json"
    static let nojsoncallback = 1
    
  }
    
    static func hasConnection(host: String? = nil) -> Bool{
        let manager = host == nil ? NetworkReachabilityManager() : NetworkReachabilityManager(host: host!)
        if let manager = manager{
            return manager.isReachable
        }
        return false
    }
    
    static func showBannerView(title: String? , subtitle: String? = nil, rootView: UIView? = nil, isError: Bool = true , position: BannerPosition = .top) {
        var color = UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000)
        if isError{
            color = UIColor.red
        }
        let banner = Banner(title: title, subtitle: subtitle, backgroundColor: color)
        banner.dismissesOnTap = true
        banner.springiness = .none
        banner.position = position
        if let rootView = rootView{
            banner.show(rootView, duration: 4.0)
        }else{
            banner.show(duration: 4.0)
        }
    }

    
    
    
    
}
