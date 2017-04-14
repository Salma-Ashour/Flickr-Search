//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by Salma Ashour on 4/14/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo");
    }

    @NSManaged public var farm: Int32
    @NSManaged public var id: String?
    @NSManaged public var isfamily: Bool
    @NSManaged public var isfriend: Bool
    @NSManaged public var ispublic: Bool
    @NSManaged public var owner: String?
    @NSManaged public var secret: String?
    @NSManaged public var server: String?
    @NSManaged public var title: String?
    @NSManaged public var isMore: Bool

}
