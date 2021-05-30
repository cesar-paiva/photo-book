//
//  MockServiceController.swift
//  PhotoBookTests
//
//  Created by Cesar Paiva on 06/01/20.
//  Copyright © 2020 Cesar Paiva. All rights reserved.
//

import Foundation
import XCTest
@testable import PhotoBook

class MockServiceController: ServiceController {
    
    var fetchFromURLExpectation: (XCTestExpectation, expectedURLString: String)?
    var shouldFailOnFetch = false
    var dataToReturnOnSuccess: Data?
    
    override func fetchFromURL(urlString: String?, success: @escaping (Data) -> Void, failure: @escaping (NSError) -> Void) {
        
        if let (expectation, expectedValue) = self.fetchFromURLExpectation {
            
            if urlString?.compare(expectedValue) == .orderedSame {
                expectation.fulfill()
            }
            
        }
        
        if shouldFailOnFetch {
            failure(NSError(domain: "ServiceController", code: 102, userInfo: nil))
            return
        }
        
        if let dataToReturnOnSuccess = dataToReturnOnSuccess {
            success(dataToReturnOnSuccess)
            return
        }
        
        super.fetchFromURL(urlString: urlString, success: success, failure: failure)

    }
    
}
