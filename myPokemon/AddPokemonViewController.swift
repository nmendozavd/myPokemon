//
//  AddPokemonViewController.swift
//  myPokemon
//
//  Created by user on 1/24/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class AddPokemonViewController: UIViewController {

    var delegate: AddPokemonViewControllerDelegate?
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var typeField: UITextField!
    @IBOutlet var weightField: UITextField!
    @IBOutlet var numberField: UITextField!
    
    
    @IBAction func catchButtonPressed(_ sender: UIButton) {
        
        print("catchpressed")
        
        if nameField.text != "" && typeField.text != "" && weightField.text != "" && numberField.text != "" {
            
            if let weight:Double = Double(weightField.text!) {
                if let number:Int = Int(numberField.text!) {
                    
                    print("about to use delegate")
                    delegate?.addPokemonUpdateType(name: nameField.text!, type: typeField.text!, weight: weight, number: number)
                }
                else {
                    print("failed to convert number")
                    return
                }
            }
            else {
                print("failed to convert weight")
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
