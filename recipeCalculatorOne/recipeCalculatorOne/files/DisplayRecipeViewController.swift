//
//  DisplayRecipeViewController.swift
//  recipeCalculatorOne
//
//  Created by Rinni Swift on 8/2/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

class DisplayRecipeViewController: UIViewController {
    
    @IBOutlet weak var recipeTextField: UITextField!
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
        let destination = segue.destination as? SecondViewController
            else { return }
        
        switch identifier {
        case "saveRecipe":
            print("save recipe bar button item tapped.")
        case "cancelRecipe":
            print("cancel recipe bar button item tapped")
        default:
            print("unexpected segue identifier.")
        }
        
    }
    
}
