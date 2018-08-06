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
    
    var rec: Recipe?
    
    @IBOutlet weak var recipeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipe = rec {
            recipeTextField.text = recipe.recipeTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
        let destination = segue.destination as? SecondViewController
            else { return }
        
        switch identifier {
        case "saveRecipe" where rec != nil:
            rec?.recipeTitle = recipeTextField.text ?? ""
            
        case "saveRecipe" where rec == nil:
            let rec = CoreDataHelper.newRecipe()
            rec.recipeTitle = recipeTextField.text ?? ""
            
            CoreDataHelper.saveRecipe()
            
        case "cancelRecipe":
            print("cancel recipe bar button item tapped")
        default:
            print("unexpected segue identifier.")
        }
        
    }
    
}
