//
//  FlickrSearchAPIController.swift
//  Flickr-Search
//
//  Created by Salma Ashour on 4/7/17.
//  Copyright © 2017 Salma. All rights reserved.
//

import Foundation
import HandyJSON
import Alamofire

class FlickrSearchAPIController{
    
    static func searchFlickr(term: String, handler: @escaping ((Bool, [Photo]?) -> Void)) {
        
        let params: Parameters = ["api_key": Const.api_key, "method": Const.flickrSerachMethod, "text": term, "per_page": Const.pre_page, "format": Const.format, "nojsoncallback": Const.nojsoncallback]
        
        
        Alamofire.request(Const.baseURL, method: .get, parameters: params).responseString { (response) in
            
            print(response)
            if(response.result.isSuccess) //Success
            {
                let jsonData = response.result.value!
                if let returnedResult = [Photo].deserialize(from: jsonData, designatedPath: "photos.photo") {
                   let photos = returnedResult as! [Photo]
                    print("**********************\(photos[0].title)")
                    handler(true, photos)
                }
            }
            else {
                handler(false, nil)
            }
        }
    }
    
    static func generateFlickerImageURL(farm: Int, server: String, id: String, secret: String, size: String) -> URL?{
        
        if let url =  URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg") {
            
            return url
        }
        return nil
    }
    
    
    static func getUserPhotos(userID: String, handler: @escaping ((Bool, [Photo]?) -> Void)) {
        
        let params: Parameters = ["api_key": Const.api_key, "user_id": userID, "method": Const.userPhotosMethod, "per_page": Const.pre_page, "format": Const.format, "nojsoncallback": Const.nojsoncallback]
        
        
        Alamofire.request(Const.baseURL, method: .get, parameters: params).responseString { (response) in
            
            print(response)
            if(response.result.isSuccess) //Success
            {
                let jsonData = response.result.value!
                if let returnedResult = [Photo].deserialize(from: jsonData, designatedPath: "photos.photo") {
                    let photos = returnedResult as! [Photo]
                    
                    handler(true, photos)
                }
            }
            else {
                handler(false, nil)
                
            }
        }
    }
}








