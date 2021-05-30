//
//  CollectionViewController.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 16/12/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "CollectionViewCell"
private let headerReuseIdentifier = "CollectionViewSectionHeader"

class CollectionViewController: UICollectionViewController {
    
    var viewModel: CollectionViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.viewModel == nil {
            self.viewModel = CollectionViewModel(view: self)
        }
        
        self.viewModel?.performInitialViewSetup()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        guard let viewModel = viewModel else { return 0 }
        
        return viewModel.numberOfSections()
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let viewModel = viewModel else { return 0 }
        
        return viewModel.numberOfItemsInSection(section)
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        
        guard let viewModel = viewModel,
            let collectionViewCell = cell as? CollectionViewCell,
            let cellViewModel = viewModel.cellViewModel(indexPath: indexPath) else {
                return cell
        }
    
        collectionViewCell.viewModel = cellViewModel
        cellViewModel.setView(collectionViewCell)
        
        collectionViewCell.setup()
    
        return collectionViewCell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
        
        guard let viewModel = viewModel,
            let sectionHeader = header as? CollectionViewSectionHeader,
            let sectionHeaderViewModel = viewModel.headerViewModel(indexPath: indexPath) else {
                return header
        }
        
        sectionHeader.viewModel = sectionHeaderViewModel
        sectionHeaderViewModel.setView(sectionHeader)
        
        sectionHeader.setup()
        
        return sectionHeader
        
    }

}

extension CollectionViewController: CollectionViewControllerProtocol {
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func setNavigationTitle(_ title: String) {
        self.title = title
    }
    
    func setSectionInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        
        if let collectionView = self.collectionView,
            let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.sectionInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        }
        
    }
    
    func setupCollectionViewCellToUseMaxWidth() {
        
        if let collectionView = self.collectionView,
            let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.itemSize = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width * 0.6)
        }
        
    }
    
    
}
