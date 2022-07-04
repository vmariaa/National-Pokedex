//
//  HelperClass.swift
//  National Pokedex
//
//  Created by Vanda S. on 29/06/2022.
//

import Foundation

class Helper {
    static let loadedNotificationKey = "co.mariam.loaded"
    static var pokemonFetched = [Pokemon]()
    static var filteredData: [Pokemon] = []
    static var favourite: [Pokemon] = []
    static var favouriteId: [Int] = []
    static var buttonWasClicked = false
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveUrl = DocumentsDirectory.appendingPathComponent("favourite").appendingPathExtension("plist")
    
    static func loadFavourite() -> [Int]? {
        guard let favourite = try? Data(contentsOf: ArchiveUrl) else {
            return nil
        }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Int>.self, from: favourite)
    }
    
    static func saveFavourite(_ favourites: [Int]) {
            let propertyListEncoder = PropertyListEncoder()
        guard let codedfavourite = try? propertyListEncoder.encode(favourites) else {
            return
        }
        do {
            try codedfavourite.write(to: ArchiveUrl, options: .noFileProtection)
        } catch {
            print("Couldn't save data, archiveURL: \(ArchiveUrl)")
        }
    }
}
