//
//  DownloadListenerProtocol.swift
//  PhotoBook
//
//  Created by Cesar Paiva on 07/01/20.
//  Copyright © 2020 Cesar Paiva. All rights reserved.
//

import Foundation

protocol DownloadListenerProtocol: class {
    
    func didDownloadImage() -> Void
    
}
