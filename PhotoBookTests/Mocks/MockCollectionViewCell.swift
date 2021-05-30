//
//  MockCollectionViewCell.swift
//  PhotoBookTests
//
//  Created by Cesar Paiva on 04/01/20.
//  Copyright © 2020 Cesar Paiva. All rights reserved.
//

import Foundation
import XCTest
@testable import PhotoBook

class MockCollectionViewCell : CollectionViewCellProtocol {
    
    var expectationForLoadImage:(XCTestExpectation, String?)?
    var expectationForSetCaption:(XCTestExpectation, String?)?
    var expectationForSetupShotDetails:(XCTestExpectation, String?)?
    
    func updateImage(image: UIImage?) {
        
    }
    
    func setCaption(captionText:String) {
        
        guard let (expectation, expectedValue) = self.expectationForSetCaption else {
            return
        }
        
        if let expectedValue = expectedValue {
            if (captionText.compare(expectedValue) != .orderedSame) {
                return
            }
        }
        
        expectation.fulfill()
        
    }
    
    func setShotDetails(shotDetailsText:String) {
        
        guard let (expectation, expectedValue) = self.expectationForSetupShotDetails else {
            return
        }
        
        if let expectedValue = expectedValue {
            if (shotDetailsText.compare(expectedValue) != .orderedSame) {
                return
            }
        }
        
        expectation.fulfill()
        
    }
    
}
