//
//  MockDownloadListener.swift
//  PhotoBookTests
//
//  Created by Cesar Paiva on 07/01/20.
//  Copyright © 2020 Cesar Paiva. All rights reserved.
//

import Foundation
import XCTest
@testable import PhotoBook

class MockDownloadListener: DownloadListenerProtocol {
    
    var didDownloadImageExpectation: XCTestExpectation?
    
    func didDownloadImage() -> Void {
        didDownloadImageExpectation?.fulfill()
    }
    
}
