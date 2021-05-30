//
//  MockPhoto.swift
//  PhotoBookTests
//
//  Created by Cesar Paiva on 07/01/20.
//  Copyright © 2020 Cesar Paiva. All rights reserved.
//

import Foundation
import XCTest

@testable import PhotoBook

class MockPhoto: Photo {

    var downloadImageExpectation: XCTestExpectation?
    
    override func downloadImage() -> Void {
        
        downloadImageExpectation?.fulfill()
        super.downloadImage()
        
    }
    
    
}
