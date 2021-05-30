//
//  CollectionViewControllerProtocol.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 20/12/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import UIKit

protocol CollectionViewControllerProtocol: class {
    
    func setNavigationTitle(_ title: String)
    func setSectionInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    func setupCollectionViewCellToUseMaxWidth()
    func reloadCollectionView()
    
}
