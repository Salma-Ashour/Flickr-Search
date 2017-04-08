//
//  FlickrUserPhotoCell.swift
//  Flickr-Search
//
//  Created by Salma Ashour on 4/8/17.
//  Copyright © 2017 Salma. All rights reserved.
//

import UIKit

class FlickrUserPhotoCell: UITableViewCell {

    @IBOutlet weak var flickrImage: UIImageView!
    @IBOutlet weak var flickrPhotoTitleLB: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    func setupCell(photo: Photo){
        flickrPhotoTitleLB.text = photo.title
        
        let flickrImageURL = FlickrSearchAPIController.generateFlickerImageURL(farm: Int(photo.farm), server: photo.server!, id: photo.id!, secret: photo.secret!, size: "m")
        flickrImage.kf.setImage(with: flickrImageURL)
        
        
    }

}
