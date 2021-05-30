//
//  ServiceController.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 05/01/20.
//  Copyright © 2020 Cesar Paiva. All rights reserved.
//

import Foundation

class ServiceController {
    
    var session: URLSessionProtocol?
    private var dataTask: URLSessionDataTask?
    
    init() {
        
        self.session = URLSession(configuration: URLSessionConfiguration.default)
        
    }
    
    func fetchFromURL(urlString: String?, success: @escaping(Data) -> Void, failure: @escaping(NSError) -> Void) {
        
        let domain = String(describing: self)
        
        guard let session = session else {
            failure(NSError(domain: domain, code: 100, userInfo: nil))
            return
        }
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            failure(NSError(domain: domain, code: 101, userInfo: nil))
            return
        }
        
        dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let error = error {
                failure(error as NSError)
                return
            }
            
            if let response = response as? HTTPURLResponse, let data = data {
                
                if response.statusCode == 200 {
                    success(data)
                    return
                }
                
            }
            
            failure(NSError(domain: domain, code: 102, userInfo: nil))
            return
            
        })
        
        dataTask?.resume()
        
    }
    
    
}
