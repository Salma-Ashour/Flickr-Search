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
        
        let params: Parameters = ["api_key": Const.api_key, "method": "flickr.photos.search", "text": term, "per_page": 20, "format": "json", "nojsoncallback": 1]
        
        
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
    
    static func generateFlickerImageURL(farm: Int, server: String, id: String, secret: String, size: String) -> URL?{
        
        if let url =  URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg") {
            
            return url
        }
        return nil
    }
}


    
    
    
    
    

