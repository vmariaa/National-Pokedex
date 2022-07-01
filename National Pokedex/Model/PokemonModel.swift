//
//  PokemonModel.swift
//  National Pokedex
//
//  Created by Vanda S. on 21/06/2022.
//

import Foundation
import UIKit
import PokemonAPI

class Pokemon {
    let id: Int?
    let name: String?
    let height: Int?
    let baseExperience: Int?
    let weight: Int?
    let type: [String?]
    let stats: [Int?]
    let imageURL: URL?
    var image: UIImage?
    var favourited: Bool = false

    init(id: Int?, name: String?, height: Int?, baseExperience: Int?, weight: Int?, type: [String?], stats: [Int?], imageURL: URL?, image: UIImage?) {
        self.id = id
        self.name = name
        self.height = height
        self.baseExperience = baseExperience
        self.weight = weight
        self.type = type
        self.stats = stats
        self.imageURL = imageURL
        self.image = image
    }
}

