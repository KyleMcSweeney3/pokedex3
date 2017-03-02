//
//  pokemon.swift
//  pokedex
//
//  Created by Kyle McSweeney on 2/03/2017.
//  Copyright © 2017 Kyle McSweeney. All rights reserved.
//

import Foundation

class Pokemon {
    
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    
    // Getter
    var name: String {
        return _name
    }

    var pokedexId: Int {
        return _pokedexId
    }
    
    // Setter
    init(name: String, pokedexId: Int) {
    
        self._name = name
        self._pokedexId = pokedexId
        
    }
    
}
