//
//  MockCollectionViewController.swift
//  PhotoBookTests
//
//  Created by Cesar Paiva on 20/12/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import Foundation
import XCTest
@testable import PhotoBook

class MockCollectionViewController: CollectionViewControllerProtocol {
    
    var expectationForSetNavigationTitle: XCTestExpectation?
    var expectationForSetSectionInset: XCTestExpectation?
    var expectationForSetupCollectionViewCellToUseMaxWidth: XCTestExpectation?
    
    func setNavigationTitle(_ title: String) {
        expectationForSetNavigationTitle?.fulfill()
    }
    
    func setSectionInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        expectationForSetSectionInset?.fulfill()
    }
    
    func setupCollectionViewCellToUseMaxWidth() {
        expectationForSetupCollectionViewCellToUseMaxWidth?.fulfill()
    }
    
    func reloadCollectionView() {
        
    }
    
}
