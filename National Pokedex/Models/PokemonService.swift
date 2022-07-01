//
//  PokemonService.swift
//  National Pokedex
//
//  Created by Vanda S. on 21/06/2022.
//

import Foundation
import UIKit
import PokemonAPI

func getPokemon(completion: @escaping([Pokemon], Pokemon) -> ()) {
    var pokeData = [Pokemon]()
        for id in 1...151 {
            PokemonAPI().pokemonService.fetchPokemon(id) { result in
                switch result {
                case .success(let pokemon):
                    var types = [String]()
                    for type in pokemon.types! {
                        let typeName = type.type?.name
                        types.append(typeName!)
                    }
                    var stats = [Int?]()
                    for stat in pokemon.stats! {
                        stats.append(stat.baseStat)
                    }
                    var newPoke = Pokemon(id: pokemon.id, name: pokemon.name, height: pokemon.height, baseExperience: pokemon.baseExperience, weight: pokemon.weight, type: types, stats: stats, imageURL: URL(string: (pokemon.sprites?.frontDefault)!), image: nil)
                    pokeData.append(newPoke)
                  
                    pokeData.sort { newPoke1, newPoke2 in
                        return newPoke1.id! < newPoke2.id!
                    }
                    completion(pokeData, newPoke)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }

func getImage(url: URL, completion: @escaping (UIImage)->()) {

        let urlRequest = URLRequest(url: url)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error =  error {
                print (error.localizedDescription)
                return
            }
            guard let data = data  else { return }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }.resume()
    }
