//
//  ViewController.swift
//  National Pokedex
//
//  Created by Vanda S. on 21/06/2022.
//

import UIKit

class PokedexViewController: UIViewController {
    
    
    @IBOutlet weak var pokedexTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var favouritesButton: UIBarButtonItem?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pokedexTableView.reloadData()
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.setTitleTextAttributes([.font: UIFont(name: "Kohinoor Bangla", size: 17)!], for: .normal)
        pokedexTableView.delegate = self
        pokedexTableView.dataSource = self
        searchBar.delegate = self
        checkForFavourites()
        favouritesButton?.isEnabled = false
        favouritesButton = UIBarButtonItem()
        addBarButton()
        
 
        getPokemon { [weak self] pokemon, newPoke in
            Helper.filteredData = pokemon
                getImage(url: newPoke.imageURL!) { [weak self] image in
                    newPoke.image = image
                    DispatchQueue.main.async {
                        self?.pokedexTableView.reloadData()
                    }
                }
                DispatchQueue.main.async {
                    if Helper.filteredData.count != 151 {
                        self?.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Loading Pokedex...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "font")!])
                        self?.searchBar.isUserInteractionEnabled = false
                        self?.favouritesButton?.isEnabled = false
                    } else {
                        Helper.pokemonFetched = Helper.filteredData
                        self?.checkForFavourites()
                        self?.favouritesButton?.isEnabled = true
                        self?.searchBar.placeholder = ""
                        self?.searchBar.isUserInteractionEnabled = true
                        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
                        tap.cancelsTouchesInView = false
                        self?.view.addGestureRecognizer(tap)
                        self?.favouritesButton?.isEnabled = true
                        self?.pokedexTableView.reloadData()
                    }
                    self?.pokedexTableView.reloadData()
                    }
                }
        initialViewSetup()
    }

    
    func addBarButton() {
        favouritesButton = UIBarButtonItem(title: "Favourites", style: .plain, target: self, action: #selector(showFavourites))
        favouritesButton?.tintColor = UIColor(named: "font")!
        favouritesButton?.setTitleTextAttributes([.font: UIFont(name: "Kohinoor Bangla", size: 17)!], for: .normal)
        favouritesButton?.setTitleTextAttributes([.font: UIFont(name: "Kohinoor Bangla", size: 17)!], for: .disabled)
        navigationItem.rightBarButtonItem = favouritesButton
    }
    
    func checkForFavourites() {
        checkForNil()
        guard !Helper.favouriteId.isEmpty else {
            return
        }
        for pokemon in Helper.pokemonFetched {
            if Helper.favouriteId.contains(pokemon.id!) {
                Helper.favourite.append(pokemon)
            }
        }
    }
    
    func checkForNil() {
        guard let data = Helper.loadFavourite() else {
            return
        }
        Helper.favouriteId = data
    }
    
    
    func initialViewSetup() {
        pokedexTableView.separatorStyle = .none

        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)

        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont(name: "Kohinoor Bangla Semibold", size: 32)!, .foregroundColor: UIColor(named: "font")!]
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "Kohinoor Bangla Semibold", size: 17)!, .foregroundColor: UIColor(named: "font")!]
        pokedexTableView.layer.backgroundColor = UIColor.clear.cgColor
        pokedexTableView.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = .systemGray3.withAlphaComponent(0.1)
        navigationController?.navigationBar.tintColor = UIColor(named: "font")!
        navigationItem.backButtonTitle = "Back"
        navigationItem.backBarButtonItem?.setTitleTextAttributes([.font: UIFont(name: "Kohinoor Bangla", size: 17)!], for: .normal)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "gradient-1.png")!)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func showFavourites(sender: UIBarButtonItem) {
        Helper.buttonWasClicked = !Helper.buttonWasClicked
        if Helper.buttonWasClicked {
            let noFavourites = UIAlertController(title: "You don't have favourite pokemon", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            noFavourites.addAction(cancel)
                guard !Helper.favourite.isEmpty else {
                present(noFavourites, animated: true, completion: nil)
                    Helper.buttonWasClicked = false
                return
            }
            Helper.filteredData = Helper.favourite
            navigationItem.title = "Favourites"
            favouritesButton?.title = "Go back"
            pokedexTableView.reloadData()
        } else {
            navigationItem.title = "Pokedex"
            favouritesButton?.title = "Favourites"
            Helper.filteredData = Helper.pokemonFetched
            pokedexTableView.reloadData()
        }
    }
}

extension PokedexViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Helper.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell") as! PokeCell

        cell.backgroundColor = UIColor.clear
        
        cell.setConstraints()
        
        cell.pokemonName.font = UIFont(name: "Kohinoor Bangla Semibold", size: 21)
        cell.pokemonName.textColor = UIColor(named: "font")!
        cell.pokemonName.text = "#\(Helper.filteredData[indexPath.row].id!)  \(Helper.filteredData[indexPath.row].name!.capitalized)"
        
        cell.pokemonTypeImage.image = UIImage(named: (Helper.filteredData[indexPath.row].type[0])!)
        
        cell.cellView.layer.cornerRadius = 10
        cell.cellView.layer.backgroundColor = UIColor(named: "purpleSet")!.withAlphaComponent(0.3).cgColor
        cell.cellView.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.cellView.layer.shadowRadius = 5
        cell.cellView.layer.shadowOpacity = 0.3
        
        cell.starButton.tintColor = UIColor(named: "font")
        
        if !Helper.favouriteId.contains(Helper.filteredData[indexPath.row].id!) {
            cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        
        DispatchQueue.main.async {
            cell.pokemonImage.image = Helper.filteredData[indexPath.row].image
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Helper.pokemonFetched.count != 151 {
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        tableView.deselectRow(at: indexPath, animated: true)
        vc.selectedImage = Helper.filteredData[indexPath.row].image
        vc.selectedPokemon = Helper.filteredData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

 }

extension PokedexViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Helper.filteredData = []
  
        if searchText == "" {
            switch Helper.buttonWasClicked {
            case true:
                Helper.filteredData = Helper.favourite
            case false:
                Helper.filteredData = Helper.pokemonFetched
            }
        } else {
           // filteredData = []
            switch Helper.buttonWasClicked{
            case true:
                for pokemon in Helper.favourite {
                    if pokemon.name!.starts(with: searchText.lowercased()) {
                        
                        Helper.filteredData.append(pokemon)
                    }
                }
            case false:
                for pokemon in Helper.pokemonFetched  {
                    if pokemon.name!.starts(with: searchText.lowercased()) {
                        
                        Helper.filteredData.append(pokemon)
                    }
                }
            }
            
        }
        self.pokedexTableView.reloadData()
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
