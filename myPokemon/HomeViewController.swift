//
//  ViewController.swift
//  myPokemon
//
//  Created by user on 1/24/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet var myTableView: UITableView!
    
    var pokeTypeArr = [String]()
    var colorArr = [UIColor]()
    var pokemonArr = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setTableView() {
        
        fetchAndReload(type: nil)
        
        pokeTypeArr = []
        colorArr = []
        
        for item in pokemonArr {
            
            if pokeTypeArr.contains(item.type!) == false {
                pokeTypeArr.append(item.type!)
                if item.type == "Fire" {
                    colorArr.append(.red)
                }
                else if item.type == "Water" {
                    colorArr.append(.blue)
                }
                else if item.type == "Grass" {
                    colorArr.append(.green)
                }
                else if item.type == "Rock" {
                    colorArr.append(.gray)
                }
                else if item.type == "Electric" {
                    colorArr.append(.orange)
                }
                else {
//                    let randomColor = arc4random_uniform(UInt32(colorArr.count))
//                    colorArr.append(colorArr[Int(randomColor)])
                }
            }
        }
        
        myTableView.reloadData()
    }

    //Core Data
    
    func saveContext() {
        
        print("in save context")
        if managedObjectContext.hasChanges {
            
            do {
                try managedObjectContext.save()
            } catch {
                print("failed to save", error)
            }
        }
    }
    
    func fetchAndReload(type: String?) {
        
        let request:NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        
        if let myType = type {
            request.predicate = NSPredicate(format: "type CONTAINS %@", myType)
        }
        
        do {
            let result = try managedObjectContext.fetch(request)
            pokemonArr = result
        } catch {
            print("failed in fetch", error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addPokemonSegue" {
            let destination = segue.destination as! AddPokemonViewController
            destination.delegate = self
        }
        if segue.identifier == "showPokemonSegue" {
            let destination = segue.destination as! ShowPokemonTableViewController
            let cell = sender as! IndexPath
            let type = pokeTypeArr[cell.row]
            destination.type = type
            destination.delegate = self
            fetchAndReload(type: type)
            print(pokemonArr.count)
            destination.pokemon = pokemonArr
            destination.tableView.backgroundColor = colorArr[cell.row]
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showPokemonSegue", sender: indexPath)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokeTypeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        let type = pokeTypeArr[indexPath.row]
        cell.textLabel?.text = "My " + type + " Type"
        cell.textLabel?.font = UIFont(name: "Chalkboard SE", size: 14)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = colorArr[indexPath.row]
        tableView.rowHeight = 80
//        tableView.separatorInset.bottom = 10.0
//        tableView.separatorColor = .white
//        tableView.separatorStyle = .singleLine
        tableView.reloadData()
        return cell
    }
}

extension HomeViewController: AddPokemonViewControllerDelegate {
    
    func addPokemonUpdateType(name: String, type: String, weight: Double, number: Int) {
        
        let newPoke:Pokemon = Pokemon(context: managedObjectContext)
        newPoke.name = name
        newPoke.type = type
        newPoke.weight = weight
        newPoke.number = Int64(number)
        saveContext()
        print("saved successfully")
        fetchAndReload(type: nil)
        setTableView()
        navigationController?.popViewController(animated: true)
    }
}

extension HomeViewController: DeletePokemonViewControllerDelegate {
    func deletePokemon(pokemon: Pokemon, noneLeft: Bool) {
        
        print("home delete")
        //del from context and update context
        managedObjectContext.delete(pokemon)
        saveContext()
        fetchAndReload(type: nil)
        setTableView()
        
        // pop controller
        if noneLeft == true {
            navigationController?.popViewController(animated: false)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}
