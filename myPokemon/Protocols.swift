//
//  Protocols.swift
//  myPokemon
//
//  Created by user on 1/24/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

protocol AddPokemonViewControllerDelegate {
    
    func addPokemonUpdateType(name: String, type: String, weight: Double, number: Int)
}

protocol DeletePokemonViewControllerDelegate {
    
    func deletePokemon(pokemon: Pokemon, noneLeft: Bool)
}
