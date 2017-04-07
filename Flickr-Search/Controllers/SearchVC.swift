//
//  SearchVC.swift
//  Flickr-Search
//
//  Created by Salma Ashour on 4/7/17.
//  Copyright © 2017 Salma. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    var flickrPhotos: [Photo] = []
    
    //MARK:- IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photosTBV: UITableView!
    
    
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
        FlickrSearchAPIController.searchFlickr(term: term) {
            result, photos in
            
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

extension SearchVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension SearchVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flickrPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchCell = photosTBV.dequeueReusableCell(withIdentifier: "searchCell") as! SearchCell
        searchCell.setupCell(photo: flickrPhotos[indexPath.row])
        return searchCell
        }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
}

extension SearchVC: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        getPhotos(term: searchBar.text!)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    
    
}

