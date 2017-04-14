//
//  DataBaseTest.swift
//  Flickr-Search
//
//  Created by Salma Ashour on 4/14/17.
//  Copyright © 2017 Salma. All rights reserved.
//

import XCTest
import CoreData

@testable import Flickr_Search
class DataBaseTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testFetch() {
        let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: DataBaseHelper.managedContext!)
        photo.setValue(3, forKey: "farm")
        photo.setValue("33220424043", forKey: "id")
        photo.setValue(false, forKey: "isfamily")
        photo.setValue(false, forKey: "isfriend")
        photo.setValue(true, forKey: "ispublic")
        photo.setValue("148154452@N07", forKey: "owner")
        photo.setValue("723a3227b0", forKey: "secret")
        photo.setValue("2875", forKey: "server")
        photo.setValue("ddd!", forKey: "title")
        photo.setValue(false, forKey: "isMore")
        
        do {
            try DataBaseHelper.managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }

    func testDelete(){
     
        DataBaseHelper.deleteAllData()
    
    }
    
    func testDeleteUserPhotos(){
        
        let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: DataBaseHelper.managedContext!)
        photo.setValue("148154452@N07", forKey: "owner")
        
        do {
            try DataBaseHelper.managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        
        DataBaseHelper.deleteUserPhotos(userID: photo.value(forKey: "owner") as! String)
        
    }
        
}
