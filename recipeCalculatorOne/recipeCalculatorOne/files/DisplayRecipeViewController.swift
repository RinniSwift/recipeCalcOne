//
//  DisplayRecipeViewController.swift
//  recipeCalculatorOne
//
//  Created by Rinni Swift on 8/2/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

class DisplayRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var rec: Recipe?
    var produce: [Produce] = []
    
    @IBOutlet weak var recipeTextField: UITextField!
    @IBOutlet weak var ingredientsRecipeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsRecipeTableView.dataSource = self
        ingredientsRecipeTableView.delegate = self
        if let recipe = rec {
            recipeTextField.text = recipe.recipeTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        produce = CoreDataHelper.retrieveProduce()
        ingredientsRecipeTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientsRecipeTableView.dequeueReusableCell(withIdentifier: "ingredientRecipeCell") as! IngredientRecipeCell
        cell.ingredientRecipeLabel.text = self.produce[indexPath.row].ingredientTitle
        return cell
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
    
    @IBAction func unwindWithSegue3(_ segue: UIStoryboardSegue) {
    
    }
    
}
