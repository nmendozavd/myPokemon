//
//  DeletePokemonViewController.swift
//  myPokemon
//
//  Created by user on 1/24/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class DeletePokemonViewController: UIViewController {

    var delegate: DeletePokemonViewControllerDelegate?
    var myPokemon: Pokemon?
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var typeField: UITextField!
    @IBOutlet var weightField: UITextField!
    @IBOutlet var numberField: UITextField!
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        delegate?.deletePokemon(pokemon: myPokemon!, noneLeft: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        delegate = navigationController?.topViewController! as! HomeViewController
        
        nameField.text = myPokemon?.name
        typeField.text = myPokemon?.type
        weightField.text = String(describing: myPokemon!.weight)
        numberField.text = String(describing: myPokemon!.number)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
