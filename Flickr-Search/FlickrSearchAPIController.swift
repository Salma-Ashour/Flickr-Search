//
//  FlickrSearchAPIController.swift
//  Flickr-Search
//
//  Created by Salma Ashour on 4/7/17.
//  Copyright © 2017 Salma. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class FlickrSearchAPIController{
    
    static func searchFlickr(term: String, handler: @escaping ((Bool, Int? ,[Photo]?) -> Void)) {
        
        let params: Parameters = [ "api_key": Utils.Const.api_key, "method": Utils.Const.flickrSerachMethod, "text": term, "per_page": Utils.Const.pre_page, "format": Utils.Const.format, "nojsoncallback": Utils.Const.nojsoncallback]
        
        
        Alamofire.request(Utils.Const.baseURL, method: .get, parameters: params).responseJSON { (response) in
            
            print(response)
            if(response.result.isSuccess) //Success
            {
                DataBaseHelper.deleteAllData()
                
                var photos: [Photo] = []
                let jsonData = JSON(response.result.value!)
                
                if jsonData["stat"] == "ok" {
                let photosArray = jsonData["photos"]["photo"].array
                for photoObject in photosArray!{
                    let photo = NSManagedObject(entity: DataBaseHelper.entity,
                                                 insertInto: DataBaseHelper.managedContext)
                    
                    photo.setValue(Int32(photoObject["farm"].intValue), forKeyPath: "farm")
                    photo.setValue(photoObject["id"].stringValue, forKeyPath: "id")
                    photo.setValue(photoObject["isfamily"].boolValue, forKeyPath: "isfamily")
                    photo.setValue(photoObject["isfriend"].boolValue, forKeyPath: "isfriend")
                    photo.setValue(photoObject["ispublic"].boolValue, forKeyPath: "ispublic")
                    photo.setValue(photoObject["owner"].stringValue, forKeyPath: "owner")
                    photo.setValue(photoObject["secret"].stringValue, forKeyPath: "secret")
                    photo.setValue(photoObject["server"].stringValue, forKeyPath: "server")
                    photo.setValue(photoObject["title"].stringValue, forKeyPath: "title")
                    photo.setValue(false, forKeyPath: "isMore")

                    do {
                        try DataBaseHelper.managedContext?.save()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                    photos.append(photo as! Photo)
                }
                handler(true, nil ,photos)
                }
                else{
                    let code = jsonData["code"].intValue
                    handler(true, code ,nil)
                }
            }
            else {
                handler(false, nil,nil)
            }
        }
    }
    
    static func generateFlickerImageURL(farm: Int, server: String, id: String, secret: String, size: String) -> URL?{
        
        if let url =  URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg") {
            
            return url
        }
        return nil
    }
    
    
    static func getUserPhotos(userID: String, handler: @escaping ((Bool, Int?, [Photo]?) -> Void)) {
        
        let params: Parameters = ["api_key": Utils.Const.api_key, "user_id": userID, "method": Utils.Const.userPhotosMethod, "per_page": Utils.Const.pre_page, "format": Utils.Const.format, "nojsoncallback": Utils.Const.nojsoncallback]
        
        
        Alamofire.request(Utils.Const.baseURL, method: .get, parameters: params).responseJSON { (response) in
            
            print(response)
            if(response.result.isSuccess) //Success
            {
                DataBaseHelper.deleteUserPhotos(userID: userID)
                
                var photos: [Photo] = []
                let jsonData = JSON(response.result.value!)
                
                 if jsonData["stat"] == "ok" {
                 let photosArray = jsonData["photos"]["photo"].array
                for photoObject in photosArray!{
                    let photo = NSManagedObject(entity: DataBaseHelper.entity,
                                                insertInto: DataBaseHelper.managedContext)
                    
                    photo.setValue(Int32(photoObject["farm"].intValue), forKeyPath: "farm")
                    photo.setValue(photoObject["id"].stringValue, forKeyPath: "id")
                    photo.setValue(photoObject["isfamily"].boolValue, forKeyPath: "isfamily")
                    photo.setValue(photoObject["isfriend"].boolValue, forKeyPath: "isfriend")
                    photo.setValue(photoObject["ispublic"].boolValue, forKeyPath: "ispublic")
                    photo.setValue(photoObject["owner"].stringValue, forKeyPath: "owner")
                    photo.setValue(photoObject["secret"].stringValue, forKeyPath: "secret")
                    photo.setValue(photoObject["server"].stringValue, forKeyPath: "server")
                    photo.setValue(photoObject["title"].stringValue, forKeyPath: "title")
                    photo.setValue(true, forKeyPath: "isMore")
                    
                    do {
                        try DataBaseHelper.managedContext?.save()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                    photos.append(photo as! Photo)
                }
                handler(true, nil,photos)
                }
                 else{
                    let code = jsonData["code"].intValue
                    handler(true, code ,nil)
                }
            }
            else {
                handler(false, nil ,nil)
                
            }
        }
    }
}
