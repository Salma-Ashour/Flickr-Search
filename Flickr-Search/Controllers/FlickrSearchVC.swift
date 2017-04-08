//
//  FlickrSearchVC
//  Flickr-Search
//
//  Created by Salma Ashour on 4/7/17.
//  Copyright © 2017 Salma. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class FlickrSearchVC: UIViewController {

    var flickrPhotos: [Photo] = []
    
    //MARK:- IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photosTBV: UITableView!
    @IBOutlet weak var activity: NVActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photosTBV.estimatedRowHeight = 170
        self.photosTBV.rowHeight = UITableViewAutomaticDimension
        searchBar.delegate = self
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPhotos(term: String){
        activity.startAnimating()
        FlickrSearchAPIController.searchFlickr(term: term) {
            result, photos in
            self.activity.stopAnimating()
            if let photos = photos{
                self.flickrPhotos.removeAll()
                self.flickrPhotos = photos
                self.photosTBV.delegate = self
                self.photosTBV.dataSource = self
                self.photosTBV.reloadData()
                
            }
        }
    }
}

extension FlickrSearchVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userPhotosVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "flickrUserPhotos") as! FlickrUserPhotosVC
        userPhotosVC.userID = self.flickrPhotos[indexPath.row].owner
        self.navigationController?.pushViewController(userPhotosVC, animated: true)
        
    }
    
}

extension FlickrSearchVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flickrPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let flickrSearchCell = photosTBV.dequeueReusableCell(withIdentifier: "flickrSearchCell") as! FlickrSearchCell
        flickrSearchCell.setupCell(photo: flickrPhotos[indexPath.row])
        return flickrSearchCell
        }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
}

extension FlickrSearchVC: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getPhotos(term: searchBar.text!)
        searchBar.resignFirstResponder()
        
    }
}

