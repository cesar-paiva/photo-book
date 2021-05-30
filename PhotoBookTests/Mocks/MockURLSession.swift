//
//  MockURLSession.swift
//  PhotoBookTests
//
//  Created by Cesar Paiva on 05/01/20.
//  Copyright © 2020 Cesar Paiva. All rights reserved.
//

import Foundation
import  XCTest
@testable import PhotoBook

class MockURLSession: URLSessionProtocol {
    
    var dataTaskExpectation: (XCTestExpectation, expectedURL: URL)?
    var dataTaskToReturn: MockURLSessionDataTask?
    
    init() {
        self.dataTaskToReturn = MockURLSessionDataTask()
    }
    
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        if let (expectation, expectedValue) = self.dataTaskExpectation {
            
            if expectedValue.absoluteString.compare(url.absoluteString) == .orderedSame {
                expectation.fulfill()
            }
            
        }
        
        self.dataTaskToReturn?.completionHandler = completionHandler
        
        return self.dataTaskToReturn!
        
    }
    
    
}
