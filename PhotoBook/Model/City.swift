//
//  City.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 18/12/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import Foundation

class City {
    
    var cityName:String?
    var photos:[Photo]?
    
    let cityKey = "city"
    let photosKey = "photos"
    
    init?(_ dictionary:[String:AnyObject]?) {
        
        guard let dictionary = dictionary,
            let cityName = dictionary[cityKey] as? String,
            let array = dictionary[photosKey] as? [AnyObject] else {
                return nil
        }
        
        self.cityName = cityName
        self.photos = [Photo]()
        
        for item in array {
            guard let dictionary = item as? [String : AnyObject] else {
                continue
            }
            if let photo = Photo(dictionary) {
                photos?.append(photo)
            }
        }
    }
}

