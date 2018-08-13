//
//  DisplayRecipeViewController.swift
//  recipeCalculatorOne
//
//  Created by Rinni Swift on 8/2/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

class DisplayRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, IngredientRecipeCellDelegate {
    
    
    var recipe: Recipe? {
        didSet {
            if let recipe = self.recipe {
                selectedIngredients = recipe.recipeProducesArray
            }
        }
    }
    
    var produce = [Produce]()
    var selectedIngredients = [RecipeProduce]()
    
    
    //    {
    //        didSet{
    ////            if let prod = rec?.produce{
    ////                produce = Array(prod) as! [Produce]
    ////            }
    //        }
    //    }
    
    ////    var produce: [Produce] = []
    //    var produceInRecipe = [Produce]() {
    //        didSet {
    //            ingredientsRecipeTableView.reloadData()
    //        }
    //    }
    
    
    @IBOutlet weak var recipeTextField: UITextField!
    
    @IBOutlet weak var ingredientsRecipeTableView: UITableView!

    
    @IBOutlet weak var priceAfterCalculateButtonTapped: UITextField!
    
    
    
    @IBAction func saveRecipe(_ sender: UIButton) {
        
        if recipeTextField.text == "" {
            return
        }
        
        //adding a new recipe
        if recipe == nil {
            let rec = CoreDataHelper.newRecipe()
            
            rec.recipeTitle = recipeTextField.text ?? ""
            
            for aRecipeProduce in selectedIngredients {
                rec.addToRecipeProduces(aRecipeProduce)
            }
          
        //editing an existing recipe
        } else {
            recipe?.recipeTitle = recipeTextField.text ?? ""
            
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
        
        //discard unsaved changes
        CoreDataHelper.rollbackUnsavedChanges()
    }
    
    
    //    @IBAction func saveRecip(_ sender: Any) {
    //
    //        if recipeTextField.text == "" {
    //            return
    //        }
    //
    //        if rec == nil {
    //            let rec = CoreDataHelper.newRecipe()
    //
    //            rec.recipeTitle = recipeTextField.text ?? ""
    //
    //            produce.forEach { (prod) in
    //                let newProd = CoreDataHelper.newProduce()
    //                newProd.ingredientAmount = prod.ingredientAmount
    //                newProd.ingredientPrice = prod.ingredientPrice
    //                newProd.userAmount = 0
    //                newProd.recipe = rec
    //                rec.addToProduce(newProd)
    //            }
    //
    //            CoreDataHelper.saveRecipe()
    //            //CoreDataHelper.saveProduce()
    //        }
    //        else {
    //            rec?.recipeTitle = recipeTextField.text ?? ""
    //              CoreDataHelper.saveRecipe()
    //
    //        }
    //
    //
    //
    //        guard let controllers = navigationController?.viewControllers else { return }
    //        print(controllers.count)
    //
    //        let secondViewController = controllers[0] as! SecondViewController
    //        navigationController?.popToViewController(secondViewController, animated: true)
    //
    //    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsRecipeTableView.dataSource = self
        ingredientsRecipeTableView.delegate = self
        if let recipe = recipe {
            recipeTextField.text = recipe.recipeTitle
        }
        
        self.recipeTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        produce = CoreDataHelper.retrieveProduce()
        
        ingredientsRecipeTableView.reloadData()
        
        //        if let recipe = rec {
        //            produceInRecipe = recipe.produce?.allObjects as! [Produce]
        //        }
    }
    
//    hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        recipeTextField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return produce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        ingredientsRecipeTableView.keyboardDismissMode = .onDrag
        let cell = ingredientsRecipeTableView.dequeueReusableCell(withIdentifier: "ingredientRecipeCell") as! IngredientRecipeCell
        let ingredient = produce[indexPath.row]
        
        cell.ingredientRecipeLabel.text = ingredient.ingredientTitle
        
        //enable/disable the amount text field if the RP exists for the `recipeIngredients`
        var recipeIngredient: RecipeProduce?
        let recipeContainsIngredient = selectedIngredients.contains(where: { (aRecipeProduce) -> Bool in
            if aRecipeProduce.produce == ingredient {
                recipeIngredient = aRecipeProduce
                
                return true
            } else {
                return false
            }
        })
        
        if recipeContainsIngredient {
            cell.checkboxButton.isSelected = true
            cell.ingredientAmount.isEnabled = true
            cell.ingredientAmount.text = String(recipeIngredient!.recipeAmount)
            
        } else {
            cell.checkboxButton.isSelected = false
            cell.ingredientAmount.isEnabled = false
            cell.ingredientAmount.text = ""
        }
        
        cell.ingredientAmount.delegate = self
        cell.ingredientAmount.tag = indexPath.row
        cell.delegate = self
        
        return cell
        //        cell.ingredientRecipeLabel.text = self.produce[indexPath.row].ingredientTitle
        //        cell.ingredientAmount.text = String( self.produce[indexPath.row].userAmount ?? 0)
        //        cell.ingredientAmount.tag = indexPath.row
        //        cell.checkboxButton.tag = indexPath.row
        //        cell.ingredientAmount.delegate = self
        
        //        if produceInRecipe.contains(produce[indexPath.row]) {
        //            cell.checkboxButton.isSelected = true
        //        } else {
        //            cell.checkboxButton.isSelected = false
        //        }
        //        INPUT TEXT TO SHOW DATA WHEN USERS INPUT DATA OF THE AMOUNT
        //        let recipeIngredients = recipe[indexPath.row]
        //        cell.ingredientAmount.text = String(recipeIngredients.recipeAmount)
    }
    
    //    func textFieldDidEndEditing(_ textField: UITextField) {
    //
    //        if Int16(textField.text!) != nil{
    //        self.produce[textField.tag].userAmount = Int16( textField.text!)!
    //        CoreDataHelper.saveProduce()
    //        }
    //        else{
    //            // alert to notice user
    //        }
    //    }
    
    func ingredientCell(_ ingredientCell: IngredientRecipeCell, checkboxTapped: UIButton, to newSelectedState: Bool) {
        guard let indexPathSelected = ingredientsRecipeTableView.indexPath(for: ingredientCell) else {
            fatalError("no index path was found for selected button")
        }
        
        let selectedProduce = produce[indexPathSelected.row]
        
        if newSelectedState == true {
            ingredientCell.ingredientAmount.isEnabled = true
            ingredientCell.ingredientAmount.text = ""
            
            //store a new RP from the selected Produce
            let newRecipeProduce = CoreDataHelper.newRecipeProduce()
            newRecipeProduce.produce = selectedProduce
            selectedIngredients.append(newRecipeProduce)
            recipe?.addToRecipeProduces(newRecipeProduce)
        } else {
            
            //disables the cell text field
            ingredientCell.ingredientAmount.isEnabled = false
            ingredientCell.ingredientAmount.text = ""
            
            //finds the recipeProduce for the deselectedProduce
            let recipeProduceFound = selectedIngredients.first { (aRecipeProduce) -> Bool in
                if aRecipeProduce.produce == selectedProduce {
                    return true
                } else {
                    return false
                }
            }
            
            //removes the recipeProduceFound from core data and the selectedIngredients array
            if let recipeProduceToDelete = recipeProduceFound {
                CoreDataHelper.delete(recProduce: recipeProduceToDelete)
                
                if let indexToDelete = selectedIngredients.index(of: recipeProduceToDelete) {
                    selectedIngredients.remove(at: Int(indexToDelete))
                }
            }
        }
    }
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        //        let index = sender.tag
        if sender.isSelected {
            //            rec?.removeFromProduce(produce[index])
            sender.isSelected = false
        } else {
            //            rec?.addToProduce(produce[index])
            sender.isSelected = true
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //update the recipiPRoduce.amount to equal the text fields text
        guard
            let textFromTextField = textField.text,
            let intFromTextField = Int16(textFromTextField)
            else {
                return
        }
        
        let editedRow = textField.tag
        let produceEdited = produce[editedRow]
        
        //selectedIngredients.first(where: { $0.produce == produceEdited })
        //is the same as
//        let recipeProduceFound = selectedIngredients.first { (aRecipeProduce) -> Bool in
//            if aRecipeProduce.produce == selectedProduce {
//                return true
//            } else {
//                return false
//            }
//        }
        
        guard let recipeProduce = selectedIngredients.first(where: { $0.produce == produceEdited }) else {
            return
        }
        
        recipeProduce.recipeAmount = intFromTextField
    }
    
    
    
    
    
    
    
    
    
    //    Insert all calculation variables here
    
    
    //shows recipe price
    @IBAction func calculateButton(_ sender: Any) {
        print("worksss")
        
        var totalCost: Double = 0.0
        
        //loop through all RecipeProduce in recipe.recipeProduceArray
        for anIngredient in selectedIngredients {
            
            //get the amount for anIngredient
            let amount = Double(anIngredient.recipeAmount)
            
            //get the produce for the current anIngredient
            guard let produceForIngredient = anIngredient.produce else {
                continue
            }
            
            //get anIngredient.produce.amount, anIngredient.produce.price
            let producePrice = Double(produceForIngredient.ingredientPrice)
            let produceAmount = Double(produceForIngredient.ingredientAmount)
            
            //cacluate the price for aRecipeProduce
            let priceForIngredient = producePrice / produceAmount * amount
            
            //add cost to the sum
            totalCost += priceForIngredient
        }
        
        //display totalCost on the UI
        priceAfterCalculateButtonTapped.text = String(format: "%.2f", totalCost)
        
    }
    
    
    
}

