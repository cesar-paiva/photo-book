//
//  CollectionViewSectionHeaderViewModel.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 04/01/20.
//  Copyright © 2020 Cesar Paiva. All rights reserved.
//

import Foundation

class CollectionViewSectionHeaderViewModel {
    
    var sectionTitle: String?
    var collectionViewSectionHeader: CollectionViewSectionHeaderProtocol?
    
    init?(model: String?) {
        
        guard let model = model else { return nil }
        
        self.sectionTitle = model

    }
    
    func setView(_ view: CollectionViewSectionHeaderProtocol) {
        self.collectionViewSectionHeader = view
    }
    
    func setup() {
        
        guard let collectionViewSectionHeader = collectionViewSectionHeader,
            let sectionTitle = sectionTitle else {
                return
        }
        
        collectionViewSectionHeader.setHeaderText(text: sectionTitle)
        
    }
    
}
