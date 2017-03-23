//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Kyle McSweeney on 10/03/2017.
//  Copyright © 2017 Kyle McSweeney. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var evolutionLbl: UILabel!
    @IBOutlet weak var currEvoLbl: UIImageView!
    @IBOutlet weak var nextEvoLbl: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name.capitalized
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = img
        currEvoLbl.image = img
        
        pokemon.downloadPokemonDetail {
            // Ensure we make it here
            print("We made it fam")
            
            //Whatever we do here will only be called after the network call is complete
            self.updateUI()
            
        }
    }
    
    func updateUI() {
        
        descriptionLbl.text = pokemon.description
        idLbl.text = "\(pokemon.pokedexId)"
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        
        if pokemon.nextEvolutionLevel != "" {
            evolutionLbl.text = "Next Evolution: \(pokemon.nextEvolutionName) LVL \(pokemon.nextEvolutionLevel)."
            print("\(pokemon.nextEvolutionId)")
            nextEvoLbl.isHidden = false
            nextEvoLbl.image = UIImage(named: pokemon.nextEvolutionId)
        } else {
            evolutionLbl.text = "This pokemon does not evolve."
            nextEvoLbl.isHidden = true
        }

    }
    
    // Take back to home view -- EASY
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    

}
