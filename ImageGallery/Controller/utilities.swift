//
//  utilities.swift
//  ImageGallery
//
//  Created by Stanislav on 20.03.2019.
//  Copyright © 2019 Stanislav Kozlov. All rights reserved.
//

import Foundation


extension String {
    func madeUnique(withRespectTo otherStrings: [String]) -> String {
        var possiblyUnique = self
        var uniqueNumber = 1
        while otherStrings.contains(possiblyUnique) {
            possiblyUnique = self + " \(uniqueNumber)"
            uniqueNumber += 1
        }
        return possiblyUnique
    }
}
