//
//  ViewController.swift
//  pokedex
//
//  Created by Kyle McSweeney on 2/03/2017.
//  Copyright © 2017 Kyle McSweeney. All rights reserved.
//

import UIKit
import AVFoundation // For working with sounds

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
        
    }
    
    func initAudio() {
        
        let path = Bundle.main.url(forResource: "music", withExtension: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: path)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    // Create a path ot pokemon.csv file
    // Parser to pull out the rows
    // Go through each row and get pokeId and name
    // Create pokemon object and add it to the array of pokemon we created earlier
    // Done in viewDidLoad()
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
                
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // Dont want to load all cells at once, only the number displayed at one time
        // Ones that go off the screen dequeue and load a new cell
        // if not return an empty cell
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
            } else {
                poke = pokemon[indexPath.row]
                
                cell.configureCell(poke)
            }
            
            
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    // Executes when cell is tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // Sets the number of items in sections
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        } else {
        
            return pokemon.count
        }
    }
    
    // nnumber of sections in collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
        
    }


    @IBAction func musicBtnPressed(_ sender: Any) {
        
        let button = sender as! UIButton
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            button.alpha = 0.3
        } else {
            musicPlayer.play()
            button.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
            
        }
    }
}

