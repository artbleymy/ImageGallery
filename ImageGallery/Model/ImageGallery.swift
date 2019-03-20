//
//  imageGallery.swift
//  ImageGallery
//
//  Created by Stanislav on 20.03.2019.
//  Copyright © 2019 Stanislav Kozlov. All rights reserved.
//

import Foundation
import UIKit

class ImageGallery {
    var name: String
    var images = [UIImage]()
    
    init(with nameOfGallery: String) {
        name = nameOfGallery
    }
    
}
