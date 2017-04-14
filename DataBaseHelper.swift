//
//  DataBaseHelper.swift
//  Flickr-Search
//
//  Created by Salma Ashour on 4/14/17.
//  Copyright © 2017 Salma. All rights reserved.
//

import Foundation
import UIKit
import CoreData

 class DataBaseHelper{
    
    static let appDelegate =
        UIApplication.shared.delegate as? AppDelegate
    
    static let managedContext =
        appDelegate?.persistentContainer.viewContext
    
    static let entity =
        NSEntityDescription.entity(forEntityName: "Photo",
                                   in: managedContext!)!
    
    static func saveToDB(photos: [Photo])
    {
        
        for photo in photos
        {
            savePhoto(photo:photo)
        }
    }
    
    static func savePhoto(photo: Photo){

        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
    }
    
    static func fetchPhotos() -> [Photo]{
        
        let isMorePredicate = NSPredicate(format: "isMore == false")

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Photo")
        
        fetchRequest.predicate = isMorePredicate
        var photos : [NSManagedObject] = []
        //3
        do {
            let result = try managedContext?.fetch(fetchRequest)
            for photo in result!{
                photos.append(photo)
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
      return photos as! [Photo]
    }
    
    static func fetchUserPhotos(userID: String) -> [Photo]{
        
        let idPredicate = NSPredicate(format: "owner == %@", userID)
        let isMorePredicate = NSPredicate(format: "isMore == true")

        let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [idPredicate, isMorePredicate])
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Photo")
        fetchRequest.predicate = andPredicate
        
        var photos : [NSManagedObject] = []
        
        do {
            let result = try DataBaseHelper.managedContext?.fetch(fetchRequest)
            for photo in result!{
                photos.append(photo)
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return photos as! [Photo]

    }
    
    
    static func deleteAllData()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
                
        do
        {
            let results = try managedContext?.fetch(fetchRequest)
            for managedObject in results!
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext?.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data error : \(error) \(error.userInfo)")
        }
    }
    
    static func deleteUserPhotos(userID: String){
        
        
        let idPredicate = NSPredicate(format: "owner == %@", userID)
        let isMorePredicate = NSPredicate(format: "isMore == true")
        
        let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [idPredicate, isMorePredicate])
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        fetchRequest.predicate = andPredicate
        
        do
        {
            let results = try managedContext?.fetch(fetchRequest)
            for managedObject in results!
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext?.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data error : \(error) \(error.userInfo)")
        }

        
    }
}
