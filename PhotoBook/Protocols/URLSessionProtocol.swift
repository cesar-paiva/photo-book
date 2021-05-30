//
//  URLSessionProtocol.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 05/01/20.
//  Copyright © 2020 Cesar Paiva. All rights reserved.
//

import Foundation

protocol URLSessionProtocol: AnyObject {
    
    func dataTask(with url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
}

extension URLSession: URLSessionProtocol {
    
}
