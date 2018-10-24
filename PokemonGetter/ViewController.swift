//
//  ViewController.swift
//  PokemonGetter
//
//  Created by Alex Richardson on 10/24/18.
//  Copyright © 2018 Alex Richardson. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var pokemonTextField: UITextField!
    
    @IBOutlet weak var typeTextView: UITextView!
    
    @IBOutlet weak var abilitiesTextView: UITextView!
    
    @IBOutlet weak var weightTextView: UITextView!
    
    @IBOutlet weak var heightTextView: UITextView!
    
    @IBOutlet weak var spriteImage: UIImageView!
    
    let baseURL = "https://pokeapi.co/api/v2/pokemon/"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard let pokemonName = pokemonTextField.text, pokemonName != "" else {
            
            return pokemonTextField.text = "Please enter in the ID or the name of the pokemon you are looking for"
            
        }
        
        let requestURL = baseURL + pokemonName.lowercased().replacingOccurrences(of: " ", with: "+")
        
        let request = Alamofire.request(requestURL)
        
        request.responseJSON { response in
            
            switch response.result {
                
           
                
            case .success(let value):
                
            let json = JSON(value)
            
            if let speciesName = json["species"]["name"].string {
                
                self.pokemonTextField.text = speciesName
                
                }
                
            if let types = json["types"].array {
                
                    var typesString = ""
                
                
                for type in types {
                    
                    if let pokeTypes = type["type"]["name"].string {
                        
                        typesString += "\(pokeTypes)" + "\n"
                        
                    }
                    
                }
                
                self.typeTextView.text = typesString
                
            }
                
            if let abilitiesJSON = json["abilities"].array {
                
                var abilities = ""
                
                for ability in abilitiesJSON {
                    
                    if let abilityName = ability["ability"]["name"].string {
                        
                        print(abilityName)
                        
                        abilities += "\(abilityName)" + "\n"
                        
                    }
                   
                }
                
                
                self.abilitiesTextView.text = abilities
               
            }
            
                
            if let weight = json["weight"].int {
                
                self.weightTextView.text = "\(weight)"
                
                }
                
                
            if let height = json["height"].int {

                
                self.heightTextView.text = "\(height)"
                
                }
                
                
            if let spriteURL = json["sprites"]["front_default"].string {
                
                if let url = URL(string: spriteURL) {
                    
                    self.spriteImage.sd_setImage(with: url, completed: nil)
                    
                }
                
                
                }
                
                
            case .failure(let error): print(error.localizedDescription)
                
            }
            
        }
        
        
        
    }
    


}

