//
//  Album.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 18/12/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import Foundation

class Album {
    
    var cities:[City]?
    var serviceController = ServiceController()
    
    init() {
        
        if cities == nil {
            cities = [City]()
        }
        
    }
    
    func load(urlString: String?, success: @escaping() -> Void, failure: @escaping(NSError) -> Void) -> Void {
        
        serviceController.fetchFromURL(urlString: urlString, success: { (receiveData) in
            
            guard let array = try? JSONSerialization.jsonObject(with: receiveData, options: .mutableContainers) as? NSArray else {
                failure(NSError(domain: "PhotoBook.Album", code: 200, userInfo: nil))
                return
            }
            
            for item in array {
                
                guard let dictionary = item as? [String: AnyObject] else { continue }
                
                if let city = City(dictionary) {
                    self.cities?.append(city)
                }
                
            }
            
            success()
            
        },
        failure: { (error) in
            failure(error)
        })

    }
    
}
