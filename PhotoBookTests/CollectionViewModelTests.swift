//
//  CollectionViewModelTests.swift
//  PhotoBookTests
//
//  Created by Cesar Paiva on 20/12/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import XCTest
@testable import PhotoBook

class CollectionViewModelTests: XCTestCase {
    
    fileprivate var mockCollectionViewController: MockCollectionViewController!
    fileprivate var sut: CollectionViewModel!

    fileprivate var stubResponseData:Data?
    fileprivate var stubServiceController:MockServiceController?
    fileprivate var albumWithStubbedServiceController:Album?
    
    override func setUp() {
        
        super.setUp()
        
        mockCollectionViewController = MockCollectionViewController()
        sut = CollectionViewModel(view:mockCollectionViewController!)
        
        let bundle = Bundle(for: type(of:self))
        let filePath = bundle.path(forResource: "ValidAlbumList", ofType: "json")
        stubResponseData = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        
        stubServiceController = MockServiceController()
        stubServiceController!.shouldFailOnFetch = false
        stubServiceController!.dataToReturnOnSuccess = stubResponseData!
        
        albumWithStubbedServiceController = Album()
        albumWithStubbedServiceController!.serviceController = stubServiceController!
        
    }

    override func tearDown() {
        super.tearDown()
        
        mockCollectionViewController = nil
        sut = nil
    }


}

// MARK: initialization tests
extension CollectionViewModelTests {
    
    func testInit_ValidView_InstantiatesObject() {
        XCTAssertNotNil(sut)
    }
    
    func testInit_ValidView_CopiesViewToIvar() {

        if let lhs = mockCollectionViewController, let rhs = sut.view
            as? MockCollectionViewController {
            XCTAssertTrue(lhs === rhs)
        }
    }
    
    func testInit_ValidView_AlbumIVarIsNotNil() {
        XCTAssertNotNil(sut.photoAlbum)
    }
    
}

// MARK: performInitialViewSetup tests
extension CollectionViewModelTests {
    
    func testPerformInitialViewSetup_Calls_SetNavigationTitle_OnCollectionViewController() {
        
        let expectation = self.expectation(description: "expected setNavigationTitle() to be caleed")
        mockCollectionViewController.expectationForSetNavigationTitle = expectation
        
        sut.performInitialViewSetup()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testPerformInitialViewSetup_Calls_SetSectionInset_OnCollectionViewController() {
        
        let expectation = self.expectation(description: "expected setSectionInset() to be called")
            mockCollectionViewController.expectationForSetSectionInset = expectation
        
        let viewModel = CollectionViewModel(view:mockCollectionViewController!)
        viewModel.performInitialViewSetup()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testPerformInitialViewSetup_Calls_SetupCollectionViewCellToUseMaxWidth_OnCollectionViewController() {
        let expectation = self.expectation(description: "expected setupCollectionViewCellToUseMaxWidth() to be called")
        mockCollectionViewController.expectationForSetupCollectionViewCellToUseMaxWidth = expectation
        
        let viewModel = CollectionViewModel(view:mockCollectionViewController!)
        viewModel.performInitialViewSetup()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)

    }
}

// MARK: numberOfSections tests
extension CollectionViewModelTests {
    
    func testNumberOfSections_ValidViewModelWithAlbum_ReturnsNumberOfCitiesInAlbum() {
        
        XCTAssertEqual(sut.numberOfSections(), sut.photoAlbum!.cities?.count)
        
    }
    
    func testNumberOfSections_ValidViewModelNilAlbum_ReturnsZero() {
        
        sut.photoAlbum = nil
        
        XCTAssertEqual(sut.numberOfSections(), 0)
    }
    
    
}

// MARK: numberOfItemInSection tests
extension CollectionViewModelTests {
    
    func testNumberOfItemsInSection_ValidViewModelNilAlbum_ReturnsZero() {
        
        sut.photoAlbum = nil
        
        XCTAssertEqual(sut.numberOfItemsInSection(0), 0)
        
    }
    
    func testNumberOfItemsInSection_ValidViewModelNilCities_ReturnsZero() {
        
        sut.photoAlbum!.cities = nil
        
        XCTAssertEqual(sut.numberOfItemsInSection(0), 0)
        
    }
    
    func testNumberOfItemsInSection_NegativeSectionIndex_ReturnsZero() {
        
        XCTAssertEqual(sut.numberOfItemsInSection(-1), 0)
        
    }
    
    func testNumberOfItemsInSection_ValidSectionIndex_ReturnsExpectedValue() {
        
        sut = CollectionViewModel(view: mockCollectionViewController!, album: albumWithStubbedServiceController)
        
        XCTAssertEqual(sut.numberOfItemsInSection(0), sut.photoAlbum!.cities![0].photos!.count)
        
    }
    
}

// MARK: cellViewModel tests
extension CollectionViewModelTests {
    
    func testCellViewModel_ValidViewModelNilAlbum_ReturnsNil() {
        
        sut.photoAlbum = nil
        
        XCTAssertNil(sut.cellViewModel(indexPath: IndexPath(row: 0, section: 0)))
        
    }
    
    func testCellViewModel_ValidViewModelNilCities_ReturnsNil() {
        
        sut.photoAlbum!.cities = nil
        
        XCTAssertNil(sut.cellViewModel(indexPath: IndexPath(row: 0, section: 0)))
        
    }
    
    func testCellViewModel_ValidViewModelNilPhotos_ReturnsNil() {
        
        sut = CollectionViewModel(view: mockCollectionViewController!, album: albumWithStubbedServiceController)
        
        sut.photoAlbum!.cities![0].photos = nil
        
        XCTAssertNil(sut.cellViewModel(indexPath: IndexPath(row: 0, section: 0)))
        
    }
    
    func testCellViewModel_NegativeRowIndex_ReturnsNil() {
        
        XCTAssertNil(sut.cellViewModel(indexPath: IndexPath(row: -1, section: 0)))
        
    }
    
    func testCellViewModel_OutOfBoundsRowIndex_ReturnsNil() {
        
        XCTAssertNil(sut.cellViewModel(indexPath: IndexPath(row: 0, section: 1000)))
    }
    
    func testCellViewModel_ValidSectionIndex_DoesNotReturnNil() {
        
        sut = CollectionViewModel(view: mockCollectionViewController!, album: albumWithStubbedServiceController)
        
        XCTAssertNotNil(sut.cellViewModel(indexPath: IndexPath(row: 0, section: 0)))
        
    }
    
    func testCellViewModel_ValidSectionIndex_ReturnsViewModelWithExpectedModelObject() {
        
        let viewModel =  CollectionViewModel(view: mockCollectionViewController!, album: albumWithStubbedServiceController)
        let rowIndex = 0
        let sectionIndex = 0
        
        let cellViewModel = viewModel.cellViewModel(indexPath: IndexPath(row: rowIndex, section: sectionIndex))
        let expectedModelObject = viewModel.photoAlbum!.cities![sectionIndex].photos![rowIndex]
        
        XCTAssertEqual(cellViewModel!.photo, expectedModelObject)
        
    }
    
}

// MARK: headerViewModel tests
extension CollectionViewModelTests {
    
    func testHeaderViewModel_ValidViewModelNilAlbum_ReturnsNil() {
        
        sut.photoAlbum = nil
        
        XCTAssertNil(sut.headerViewModel(indexPath: IndexPath(row: 0, section: 0)))
        
    }
    
    func testHeaderViewModel_ValidViewModelNilCities_ReturnsNil() {
        
        sut.photoAlbum!.cities = nil
        
        XCTAssertNil(sut.headerViewModel(indexPath: IndexPath(row: 0, section: 0)))
        
    }
    
    func testHeaderViewModel_NegativeSectionIndex_ReturnsNil() {
        
        XCTAssertNil(sut.headerViewModel(indexPath: IndexPath(row: 0, section: -1)))
        
    }
    
    func testHeaderViewModel_OutOfBoundsSectionIndex_ReturnsNil() {
        
        XCTAssertNil(sut.headerViewModel(indexPath:IndexPath(row: 0,
                                                                   section: 1000)))
    }
    func testHeaderViewModel_ValidSectionIndex_DoesNotReturnNil() {
        
        sut = CollectionViewModel(view: mockCollectionViewController!, album: albumWithStubbedServiceController)
        
        XCTAssertNotNil(sut.headerViewModel(indexPath:IndexPath(row:0, section: 0)))
        
    }
    func testHeaderViewModel_ValidSectionIndex_ReturnsViewModelWithExpectedSectionTitle() {
        
        sut = CollectionViewModel(view: mockCollectionViewController!, album: albumWithStubbedServiceController)
        
        let rowIndex = 0
        let sectionIndex = 0
        let headerViewModel = sut.headerViewModel(indexPath:IndexPath(row: rowIndex, section: sectionIndex))
        let expectedSectionTitle = sut.photoAlbum!.cities![sectionIndex].cityName!
        
        XCTAssertEqual(headerViewModel!.sectionTitle, expectedSectionTitle)
    }
    
}
