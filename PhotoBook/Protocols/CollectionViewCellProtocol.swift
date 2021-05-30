//
//  CollectionViewCellProtocol.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 04/01/20.
//  Copyright © 2020 Cesar Paiva. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewCellProtocol : AnyObject {
    
    func updateImage(image: UIImage?)
    func setCaption(captionText: String)
    func setShotDetails(shotDetailsText: String)

}
