//
//  PokeCell.swift
//  National Pokedex
//
//  Created by Vanda S. on 21/06/2022.
//

import UIKit

class PokeCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var pokemonTypeImage: UIImageView!
    @IBOutlet weak var starButton: UIButton!
    
    func setConstraints() {
        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        pokemonName.translatesAutoresizingMaskIntoConstraints = false
        pokemonTypeImage.translatesAutoresizingMaskIntoConstraints = false
        cellView.translatesAutoresizingMaskIntoConstraints = false
        starButton.translatesAutoresizingMaskIntoConstraints = false
        
        pokemonImage.backgroundColor = .clear
        pokemonImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        pokemonImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        pokemonImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 35).isActive = true
        pokemonImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pokemonImage.contentMode = .scaleAspectFill
        
        pokemonName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
        pokemonName.leftAnchor.constraint(equalTo: pokemonImage.rightAnchor, constant: 15).isActive = true
        
        pokemonTypeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        pokemonTypeImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        pokemonTypeImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        pokemonTypeImage.leftAnchor.constraint(equalTo: pokemonImage.rightAnchor, constant: 20).isActive = true
        
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11).isActive = true
        cellView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        cellView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        
        starButton.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 15).isActive = true
        starButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
    }
}
