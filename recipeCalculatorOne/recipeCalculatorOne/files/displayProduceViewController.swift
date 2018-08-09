//
//  displayProduceViewController.swift
//  recipeCalculatorOne
//
//  Created by Rinni Swift on 7/30/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

class displayProduceViewController: UIViewController {
    
    var prod: Produce?
    
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var amountDoubleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    
    
    @IBAction func saveIngredient(_ sender: Any) {
        if ingredientTextField.text == "" || amountDoubleTextField.text == "" || priceTextField.text == "" {
            return
        }
        
        // Now that we know we have data in all our fields, we want to create a new entity or modify an existing one
        if prod == nil {
            let prod = CoreDataHelper.newProduce()
            prod.ingredientTitle = ingredientTextField.text ?? ""
            prod.ingredientAmount = Int16(amountDoubleTextField.text!) ?? 0
            prod.ingredientPrice = Int16(priceTextField.text!) ?? 0
        } else  {
            prod?.ingredientTitle = ingredientTextField.text ?? ""
            prod?.ingredientAmount = Int16(amountDoubleTextField.text ?? "0")!
            prod?.ingredientPrice = Int16(priceTextField.text ?? "0.00")!
        }
        
        CoreDataHelper.saveProduce()
        
        guard let controllers = navigationController?.viewControllers else { return }
        print(controllers.count)
        
        let firstViewController = controllers[0] as! FirstViewController
        navigationController?.popToViewController(firstViewController, animated: true)
    }
    
    @IBAction func cancelIngredient(_ sender: Any) {
        
        guard let controllers = navigationController?.viewControllers else { return }
        print(controllers.count)
        
        let firstViewController = controllers[0] as! FirstViewController
        navigationController?.popToViewController(firstViewController, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let produce = prod {
            ingredientTextField.text = produce.ingredientTitle
            amountDoubleTextField.text = String(produce.ingredientAmount)
            priceTextField.text = String(produce.ingredientPrice)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if let prod = prod {
//
////            ingredientTextField.text = prod.ingredientTitle
////            amountDoubleTextField.text = prod.amountInDoubles
////            priceTextField.text = prod.ingredientPrice
////        }   else {
////            self.ingredientTextField.text = ""
////            self.amountDoubleTextField.text = ""
////            self.priceTextField.text = ""
////
////        }
//
//
////        ingredientTextField.text = ""
////        amountDoubleTextField.text = ""
////        unitTextField.text = ""
////        priceTextField.text = ""
//        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let identifier = segue.identifier,
//            let destination = segue.destination as? FirstViewController
//            else { return }
//
//        switch identifier {
//        case "save" where prod != nil:
//            prod?.ingredientTitle = ingredientTextField.text ?? ""
//            prod?.ingredientAmount = Int16(amountDoubleTextField.text ?? "0")!
//            prod?.ingredientPrice = Int16(priceTextField.text ?? "0.00")!
//
//            CoreDataHelper.saveProduce()
//
//        case "save" where prod == nil:
//            let prod = CoreDataHelper.newProduce()
//            prod.ingredientTitle = ingredientTextField.text ?? ""
//            prod.ingredientAmount = Int16(amountDoubleTextField.text!) ?? 0
//            prod.ingredientPrice = Int16(priceTextField.text!) ?? 0
//
//            CoreDataHelper.saveProduce()
//
//        case "cancel":
//            print("cancel bar button item tapped")
//
//        default:
//            print("unexpected error")
//        }
//    }
}
