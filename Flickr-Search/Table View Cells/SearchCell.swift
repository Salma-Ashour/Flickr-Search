//
//  SearchCell.swift
//  Flickr-Search
//
//  Created by Salma Ashour on 4/7/17.
//  Copyright © 2017 Salma. All rights reserved.
//

import UIKit
import Kingfisher

class SearchCell: UITableViewCell {

    
    //MARK:- IBOutlets
    @IBOutlet weak var filckrImageView: UIImageView!
    @IBOutlet weak var flickrPhotoTitleLB: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(photo: Photo){
        flickrPhotoTitleLB.text = photo.title
        
        
        let flickrImageURL = FlickrSearchAPIController.generateFlickerImageURL(farm: photo.farm!, server: photo.server!, id: photo.id!, secret: photo.secret!, size: "m")
        
        filckrImageView.kf.setImage(with: flickrImageURL)
    
    
    }

}
