//
//  CollectionViewModel.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 20/12/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import Foundation

class CollectionViewModel {
    
    weak var view: CollectionViewControllerProtocol?
    var photoAlbum: Album?
    
    init(view: CollectionViewControllerProtocol, album: Album? = nil) {
        
        self.view = view
        
        photoAlbum = album ?? Album()
        
        photoAlbum?.load(urlString: "http://www.asmtechnology.com/apress2017/albumlist.json", success: {
            
            DispatchQueue.main.async {
                self.view?.reloadCollectionView()
            }
            
        }, failure: { (error) in
            print(error.description)
        })
    }
    
    func performInitialViewSetup() {
        view?.setNavigationTitle("Photo Album")
        view?.setSectionInset(top: 20, left: 0, bottom: 0, right: 0)
        view?.setupCollectionViewCellToUseMaxWidth()
    }
    
    func numberOfSections() -> Int {
        
        guard let photoAlbum = photoAlbum, let cities = photoAlbum.cities else { return 0 }
        
        return cities.count

    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        
        guard let photoAlbum = photoAlbum, let cities = photoAlbum.cities else { return 0 }
        
        if ((section < 0) || (section >= cities.count)) {
            return 0
        }
        
        guard let photos = cities[section].photos else {
            return 0
        }
        
        return photos.count
    }
    
    func cellViewModel(indexPath: IndexPath) -> CollectionViewCellViewModel? {
        
        guard let photoAlbum = photoAlbum, let cities = photoAlbum.cities else { return nil }
        
        if ((indexPath.section < 0) || (indexPath.section >= cities.count)) {
            return nil
        }
        
        guard let photos = cities[indexPath.section].photos else { return nil }
        
        if ((indexPath.row < 0) || (indexPath.row >= photos.count)) {
            return nil
        }
        
        return CollectionViewCellViewModel(model: photos[indexPath.row])
    }
    
    func headerViewModel(indexPath: IndexPath) -> CollectionViewSectionHeaderViewModel? {
        
        guard let photoAlbum = photoAlbum, let cities = photoAlbum.cities else { return nil }
        
        if ((indexPath.section < 0) || (indexPath.section >= cities.count)) {
            return nil
        }
        
        return CollectionViewSectionHeaderViewModel(model: cities[indexPath.section].cityName)
        
    }
}
