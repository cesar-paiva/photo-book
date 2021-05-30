//
//  CollectionViewSectionHeader.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 16/12/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import UIKit

class CollectionViewSectionHeader: UICollectionReusableView {
        
    @IBOutlet weak var title: UILabel!
    
    var viewModel: CollectionViewSectionHeaderViewModel?
    
    func setup() {
        viewModel?.setup()
    }
    
}

extension CollectionViewSectionHeader: CollectionViewSectionHeaderProtocol {
    
    func setHeaderText(text: String) {
        title.text = text
    }
    
}
