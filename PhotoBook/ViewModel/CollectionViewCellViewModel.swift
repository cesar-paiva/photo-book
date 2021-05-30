//
//  CollectionViewCellModel.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 03/01/20.
//  Copyright © 2020 Cesar Paiva. All rights reserved.
//

import Foundation

class CollectionViewCellViewModel {
    
    weak var photo: Photo?
    var collectionViewCell: CollectionViewCellProtocol?
    
    init?(model: Photo?) {
        
        guard let model = model else { return nil }
        
        self.photo = model
        photo?.listener = self
        
    }
    
    func setView(_ view: CollectionViewCellProtocol) {
        self.collectionViewCell = view
    }
    
    func setup() {
        
        guard let collectionViewCell = collectionViewCell,
            let photo = photo,
            let aperture = photo.aperture,
            let shutterSpeed = photo.shutterSpeed,
            let iso = photo.iso,
            let comment = photo.comment else {
                return
        }
        
        collectionViewCell.updateImage(image: photo.downloadedImage)
        collectionViewCell.setCaption(captionText: comment)
        collectionViewCell.setShotDetails(shotDetailsText: "\(aperture), \(shutterSpeed), ISO \(iso)")
        
    }
    
}

extension CollectionViewCellViewModel: DownloadListenerProtocol {
    
    func didDownloadImage() {
        
        DispatchQueue.main.async {
            self.collectionViewCell?.updateImage(image: self.photo?.downloadedImage)
        }
        
    }
    
}
