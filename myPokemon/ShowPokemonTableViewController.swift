//
//  ShowPokemonTableViewController.swift
//  myPokemon
//
//  Created by user on 1/24/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ShowPokemonTableViewController: UITableViewController {

    var type:String?
    var pokemon: [Pokemon]?
    var delegate: DeletePokemonViewControllerDelegate?
    
    @IBOutlet var typeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myType = type {
            typeLabel.text = myType + " Type"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)
        let myPokemon = pokemon![indexPath.row]
        cell.textLabel?.text = myPokemon.name
        cell.detailTextLabel?.text = String(describing: myPokemon.number)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "deleteSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "deleteSegue" {
            
            let destination = segue.destination as! DeletePokemonViewController
            destination.delegate = self
            let indexPath = sender as! IndexPath
            let pokemonClicked = pokemon![indexPath.row]
            destination.myPokemon = pokemonClicked
        }
    }
}


extension ShowPokemonTableViewController: DeletePokemonViewControllerDelegate {
    
    func deletePokemon(pokemon: Pokemon, noneLeft: Bool) {
        
        print("will delete " + pokemon.name!)
        for i in 0...self.pokemon!.count - 1 {
            if self.pokemon![i] == pokemon {
                self.pokemon!.remove(at: i)
            }
        }
        var totalLeft:Bool = false
        if self.pokemon?.count == 0 {
            totalLeft = true
        }
        delegate?.deletePokemon(pokemon: pokemon, noneLeft: totalLeft)
        tableView.reloadData()
    }
    
}
