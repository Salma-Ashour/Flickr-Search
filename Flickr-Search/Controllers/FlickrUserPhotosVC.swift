//
//  FlickrUserPhotosVC.swift
//  Flickr-Search
//
//  Created by Salma Ashour on 4/8/17.
//  Copyright © 2017 Salma. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class FlickrUserPhotosVC: UIViewController {

    var flickrPhotos: [Photo] = []
    var userID: String!

    @IBOutlet weak var userPhotosTBV: UITableView!
    @IBOutlet weak var activity: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userPhotosTBV.delegate = self
        self.userPhotosTBV.dataSource = self
        if !hasConnection(){
           flickrPhotos =  DataBaseHelper.fetchUserPhotos(userID: userID)
            self.userPhotosTBV.reloadData()
        }
        else{
        getUserPhotos(userID: userID)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getUserPhotos(userID: String){
        activity.startAnimating()
        FlickrSearchAPIController.getUserPhotos(userID: userID) {
            result, photos in
            self.activity.stopAnimating()
            if let photos = photos{
                self.flickrPhotos.removeAll()
                self.flickrPhotos = photos
                self.userPhotosTBV.reloadData()
            }
        }
    }
    
    func hasConnection(host: String? = nil) -> Bool{
        let manager = host == nil ? NetworkReachabilityManager() : NetworkReachabilityManager(host: host!)
        if let manager = manager{
            return manager.isReachable
        }
        return false
    }
}

extension FlickrUserPhotosVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension FlickrUserPhotosVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return flickrPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userPhotoCell = userPhotosTBV.dequeueReusableCell(withIdentifier: "flickrUserPhotoCell") as! FlickrUserPhotoCell
        userPhotoCell.setupCell(photo: flickrPhotos[indexPath.row])
        return userPhotoCell
        
    }
}
