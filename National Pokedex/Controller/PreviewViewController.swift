//
//  PreviewViewController.swift
//  National Pokedex
//
//  Created by Vanda S. on 21/06/2022.
//

import UIKit
import SwiftUI

class PreviewViewController: UIViewController {

    @IBOutlet weak var pokemonImageLarge: UIImageView!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var heightNameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightNameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseExpLabel: UILabel!
    
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet weak var hpBar: UIProgressView!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var attackBar: UIProgressView!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseBar: UIProgressView!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var specialAttackBar: UIProgressView!
    @IBOutlet weak var specialAttackLabel: UILabel!
    @IBOutlet weak var specialDefenseBar: UIProgressView!
    @IBOutlet weak var specialDefenseLabel: UILabel!
    @IBOutlet weak var speedBar: UIProgressView!
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var heightStack: UIStackView!
    @IBOutlet weak var weightStack: UIStackView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var typeImage: UIImageView!
    
    
    var selectedImage: UIImage?
    var selectedPokemon: Pokemon?
    
    var addToFavsButton: UIBarButtonItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setImageView()
        setLabelData()
        setLabelConstraints()
        setTypeImage()
        setStarButton()
        setStatsConstraints()
        setBars()
        setBackgroundView()
        
        navigationItem.title = selectedPokemon?.name?.capitalized
        view.backgroundColor = UIColor(patternImage: UIImage(named: "gradient-1.png")!)
       
        pokemonImageLarge?.image = selectedImage
        addToFavsButton = UIBarButtonItem()
        setRightBarButtonItem()
        configRightBarButtonItem()
        
        guard let selectedPokemon = selectedPokemon else {
            return
        }
        
        for pokemon in Helper.favouriteId {
            if selectedPokemon.id == pokemon {
                starButton.setImage(UIImage(systemName: "star.fill")?.withTintColor(UIColor(named: "font")!), for: .normal)
            }
        }
    }

    func setRightBarButtonItem() {
        addToFavsButton = UIBarButtonItem(title: "Add to favourites", style: .plain, target: self, action: #selector(addToFavs))
        addToFavsButton?.tintColor = UIColor(named: "font")
        addToFavsButton?.setTitleTextAttributes([.font: UIFont(name: "Kohinoor Bangla", size: 17)!], for: .normal)
        navigationItem.rightBarButtonItem = addToFavsButton
        if Helper.pokemonFetched.count != 151 {
            addToFavsButton?.isEnabled = false
            addToFavsButton?.title = "Loading Pokedex..."
        }
    }
    
    func configRightBarButtonItem() {
        guard let selectedPokemon = selectedPokemon else {
            return
        }
        if (selectedPokemon.favourited == true || Helper.favouriteId.contains((selectedPokemon.id)!)) && Helper.pokemonFetched.count == 151 {
            addToFavsButton?.title = "Remove from favourites"
        }
    }
    
    func setImageView() {
        pokemonImageLarge.translatesAutoresizingMaskIntoConstraints = false
       
        pokemonImageLarge.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20).isActive = true
        pokemonImageLarge.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        pokemonImageLarge.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        pokemonImageLarge.heightAnchor.constraint(equalToConstant: 200).isActive = true
        pokemonImageLarge.contentMode = .scaleAspectFill
    }
    
    func setLabelData() {
        idLabel.text = "#\(String((selectedPokemon?.id)!))"
        idLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 28)
        idLabel.textColor = UIColor(named: "font")!
        
        heightNameLabel.text = "Height"
        heightNameLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 20)
        heightNameLabel.textColor = UIColor(named: "font")!
        heightNameLabel.textAlignment = .center
        heightLabel.text = "\(String((selectedPokemon?.height)!))0cm"
        heightLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 30)
        heightLabel.textColor = UIColor(named: "font")!
        heightLabel.textAlignment = .center
        
        weightNameLabel.text = "Weight"
        weightNameLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 20)
        weightNameLabel.textColor = UIColor(named: "font")!
        weightNameLabel.textAlignment = .center
        weightLabel.text = "\(String(((selectedPokemon?.weight)!/10)))kg"
        weightLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 30)
        weightLabel.textColor = UIColor(named: "font")!
        weightLabel.textAlignment = .center
       
        statsLabel.text = "Base Stats"
        statsLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 25)
        statsLabel.textColor = UIColor(named: "font")!
        
        baseExpLabel.text = "Base Experience: \(String((selectedPokemon?.baseExperience)!))"
        baseExpLabel.textColor = UIColor(named: "font")!
        baseExpLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 15)
        
        hpLabel.text = "HP: \(String((selectedPokemon?.stats[0])!))"
        hpLabel.textColor = UIColor(named: "font")!
        hpLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 15)
        
        attackLabel.text = "Attack: \(String((selectedPokemon?.stats[1])!))"
        attackLabel.textColor = UIColor(named: "font")!
        attackLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 15)
        
        defenseLabel.text = "Defense: \(String((selectedPokemon?.stats[2])!))"
        defenseLabel.textColor = UIColor(named: "font")!
        defenseLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 15)
        
        specialAttackLabel.text = "Special Attack: \(String((selectedPokemon?.stats[3])!))"
        specialAttackLabel.textColor = UIColor(named: "font")!
        specialAttackLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 15)
        
        specialDefenseLabel.text = "Special Defense: \(String((selectedPokemon?.stats[4])!))"
        specialDefenseLabel.textColor = UIColor(named: "font")!
        specialDefenseLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 15)
        
        speedLabel.text = "Speed: \(String((selectedPokemon?.stats[5])!))"
        speedLabel.textColor = UIColor(named: "font")!
        speedLabel.font = UIFont(name: "Kohinoor Bangla Semibold", size: 15)
    }
    
    func setLabelConstraints() {
        weightStack.translatesAutoresizingMaskIntoConstraints = false
        heightStack.translatesAutoresizingMaskIntoConstraints = false
        weightNameLabel.translatesAutoresizingMaskIntoConstraints = false
        heightNameLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        weightNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        heightNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        weightLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        heightLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        weightStack.contentMode = .center
        heightStack.contentMode = .center
        
        weightStack.spacing = 0
        heightStack.spacing = 0
        
        weightStack.heightAnchor.constraint(equalToConstant: 70).isActive = true
        weightStack.topAnchor.constraint(equalTo: pokemonImageLarge.bottomAnchor, constant: 20).isActive = true
        weightStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        
        heightStack.heightAnchor.constraint(equalToConstant: 70).isActive = true
        heightStack.topAnchor.constraint(equalTo: pokemonImageLarge.bottomAnchor, constant: 20).isActive = true
        heightStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        
        idLabel.topAnchor.constraint(equalTo: starButton.bottomAnchor, constant: 20).isActive = true
        idLabel.centerXAnchor.constraint(equalTo: starButton.centerXAnchor).isActive = true
    }
    
    func setTypeImage() {
        typeImage.translatesAutoresizingMaskIntoConstraints = false
        typeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        typeImage.centerYAnchor.constraint(equalTo: heightStack.centerYAnchor).isActive = true
        typeImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        typeImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        typeImage.image = UIImage(named: (selectedPokemon?.type[0])!)
    }
    
    func setStarButton() {
        starButton.translatesAutoresizingMaskIntoConstraints = false
        
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
        starButton.tintColor = UIColor(named: "font")
        
        starButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10).isActive = true
        starButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    func setBars() {
        hpBar.translatesAutoresizingMaskIntoConstraints = false
        attackBar.translatesAutoresizingMaskIntoConstraints = false
        defenseBar.translatesAutoresizingMaskIntoConstraints = false
        specialAttackBar.translatesAutoresizingMaskIntoConstraints = false
        specialDefenseBar.translatesAutoresizingMaskIntoConstraints = false
        speedBar.translatesAutoresizingMaskIntoConstraints = false
        
        hpBar.progress = Float((selectedPokemon?.stats[0])!)/200
        hpBar.tintColor = UIColor(named: "font")!
        hpBar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        hpBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        hpBar.centerYAnchor.constraint(equalTo: hpLabel.centerYAnchor).isActive = true
        hpBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        attackBar.progress = Float((selectedPokemon?.stats[1])!)/200
        attackBar.tintColor = UIColor(named: "font")!
        attackBar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        attackBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        attackBar.centerYAnchor.constraint(equalTo: attackLabel.centerYAnchor).isActive = true
        attackBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        defenseBar.progress = Float((selectedPokemon?.stats[2])!)/200
        defenseBar.tintColor = UIColor(named: "font")!
        defenseBar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        defenseBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        defenseBar.centerYAnchor.constraint(equalTo: defenseLabel.centerYAnchor).isActive = true
        defenseBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        specialAttackBar.progress = Float((selectedPokemon?.stats[3])!)/200
        specialAttackBar.tintColor = UIColor(named: "font")!
        specialAttackBar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        specialAttackBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        specialAttackBar.centerYAnchor.constraint(equalTo: specialAttackLabel.centerYAnchor).isActive = true
        specialAttackBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        specialDefenseBar.progress = Float((selectedPokemon?.stats[4])!)/200
        specialDefenseBar.tintColor = UIColor(named: "font")!
        specialDefenseBar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        specialDefenseBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        specialDefenseBar.centerYAnchor.constraint(equalTo: specialDefenseLabel.centerYAnchor).isActive = true
        specialDefenseBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        speedBar.progress = Float((selectedPokemon?.stats[5])!)/200
        speedBar.tintColor = UIColor(named: "font")!
        speedBar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        speedBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        speedBar.centerYAnchor.constraint(equalTo: speedLabel.centerYAnchor).isActive = true
        speedBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    }
    
    func setStatsConstraints() {
        statsLabel.translatesAutoresizingMaskIntoConstraints = false
        baseExpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hpLabel.translatesAutoresizingMaskIntoConstraints = false
        attackLabel.translatesAutoresizingMaskIntoConstraints = false
        defenseLabel.translatesAutoresizingMaskIntoConstraints = false
        specialAttackLabel.translatesAutoresizingMaskIntoConstraints = false
        specialDefenseLabel.translatesAutoresizingMaskIntoConstraints = false
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        
    
        statsLabel.topAnchor.constraint(equalTo: typeImage.bottomAnchor, constant: 60).isActive = true
        statsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        baseExpLabel.topAnchor.constraint(equalTo: statsLabel.bottomAnchor, constant: 10).isActive = true
        baseExpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        hpLabel.topAnchor.constraint(equalTo: baseExpLabel.bottomAnchor, constant: 10).isActive = true
        hpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
       
        attackLabel.topAnchor.constraint(equalTo: hpLabel.bottomAnchor, constant: 10).isActive = true
        attackLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        defenseLabel.topAnchor.constraint(equalTo: attackLabel.bottomAnchor, constant: 10).isActive = true
        defenseLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        specialAttackLabel.topAnchor.constraint(equalTo: defenseLabel.bottomAnchor, constant: 10).isActive = true
        specialAttackLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        specialDefenseLabel.topAnchor.constraint(equalTo: specialAttackLabel.bottomAnchor, constant: 10).isActive = true
        specialDefenseLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        speedLabel.topAnchor.constraint(equalTo: specialDefenseLabel.bottomAnchor, constant: 10).isActive = true
        speedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    }
    
    func setBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: statsLabel.topAnchor, constant: -10).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: 15).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: speedBar.rightAnchor, constant: 15).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: speedLabel.leftAnchor, constant: -15).isActive = true
        backgroundView.backgroundColor = .purple
        
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.backgroundColor = UIColor(named: "purpleSet")!.withAlphaComponent(0.3).cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 5, height: 5)
        backgroundView.layer.shadowRadius = 5
        backgroundView.layer.shadowOpacity = 0.3
    }
    
    @objc func addToFavs() {
        guard let selectedPokemon = selectedPokemon else {
            return
        }

        for pokemon in Helper.favourite {
            if pokemon.name == selectedPokemon.name {
                pokemon.favourited = false
                Helper.favourite.removeFirst(object: pokemon)
                if let index = Helper.favouriteId.firstIndex(of: pokemon.id!) {
                    Helper.favouriteId.remove(at: index)
                    Helper.saveFavourite(Helper.favouriteId)
                }
                starButton.setImage(UIImage(systemName: "star"), for: .normal)
                addToFavsButton?.title = "Add to favourites"
                if Helper.buttonWasClicked == true {
                    Helper.filteredData = Helper.favourite
                }
                return
            }
        }
        
        starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        addToFavsButton?.title = "Remove from favourites"
        Helper.favourite.append(selectedPokemon)
        Helper.favouriteId.append((selectedPokemon.id)!)
        Helper.saveFavourite(Helper.favouriteId)
        selectedPokemon.favourited = true
        Helper.favourite.sort { newPoke1, newPoke2 in
            return newPoke1.id! < newPoke2.id!
        }
        
    }
}


