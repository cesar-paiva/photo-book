//
//  CollectionViewCell.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 16/12/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var shotDetailsLabel: UILabel!
    
    var viewModel: CollectionViewCellViewModel?
    
    func setup() {
        viewModel?.setup()
    }
    
}

extension CollectionViewCell: CollectionViewCellProtocol {
    
    func updateImage(image: UIImage?) {
        imageView.image = image
        setNeedsLayout()
    }
    
    func setCaption(captionText: String) {
        captionLabel.text = captionText
    }
    
    func setShotDetails(shotDetailsText: String) {
        shotDetailsLabel.text = shotDetailsText
    }
    
}
