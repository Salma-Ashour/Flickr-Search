//
//  Photo.swift
//  Flickr-Search
//
//  Created by Salma Ashour on 4/7/17.
//  Copyright © 2017 Salma. All rights reserved.
//

import HandyJSON
import CoreData

class Photoo: HandyJSON{
    
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var ispublic: Bool?
    var isfriend: Bool?
    var isfamily:Bool?
    
    required init(){}
    
}
