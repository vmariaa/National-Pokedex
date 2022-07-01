//
//  ArrayExtension.swift
//  National Pokedex
//
//  Created by Vanda S. on 21/06/2022.
//

import Foundation

extension Array where Element: AnyObject {
    mutating func removeFirst(object: AnyObject) {
        guard let index = firstIndex(where: {$0 === object}) else { return }
        remove(at: index)
    }
}
