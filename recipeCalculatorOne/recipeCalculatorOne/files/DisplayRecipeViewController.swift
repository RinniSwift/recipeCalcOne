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
    
    @IBAction func saveRecipe(_ sender: Any) {
        
        if recipeTextField.text == "" {
            return
        }
        
        if rec == nil {
            let rec = CoreDataHelper.newRecipe()
            rec.recipeTitle = recipeTextField.text ?? ""
        } else {
            rec?.recipeTitle = recipeTextField.text ?? ""
        }
        
        CoreDataHelper.saveRecipe()
        
        guard let controllers = navigationController?.viewControllers else { return }
        print(controllers.count)
        
        let secondViewController = controllers[0] as! SecondViewController
        navigationController?.popToViewController(secondViewController, animated: true)
    }
    
    @IBAction func cancelRecipe(_ sender: Any) {
        guard let controllers = navigationController?.viewControllers else { return }
        let secondViewController = controllers[0] as! SecondViewController
        navigationController?.popToViewController(secondViewController, animated: true)
    }
    

    
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
    
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    
}
