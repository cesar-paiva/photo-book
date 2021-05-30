//
//  MockURLSessionDataTask.swift
//  PhotoBookTests
//
//  Created by Cesar Paiva on 05/01/20.
//  Copyright © 2020 Cesar Paiva. All rights reserved.
//

import Foundation
import XCTest

class MockURLSessionDataTask: URLSessionDataTask {
    
    var resumeExpectation: XCTestExpectation?
    var completionHandler:((Data?, URLResponse?, Error?) -> Void)?
    var dataToReturn: Data?
    var urlResponseToReturn: URLResponse?
    var errorToReturn: Error?
    
    override func resume() {
        
        resumeExpectation?.fulfill()
        
        if let completionHandler = completionHandler {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                completionHandler(self.dataToReturn, self.urlResponseToReturn, self.errorToReturn)
            }
            
        }
        
    }
    
    
}
