//
//  Array+Extension.swift
//  Memorize
//
//  Created by Rafael Melo on 23/05/23.
//

import Foundation

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
