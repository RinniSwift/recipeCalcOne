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
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let prod = prod {
            
            ingredientTextField.text = prod.ingredientTitle
            amountDoubleTextField.text = prod.amountInDoubles
            priceTextField.text = prod.ingredientPrice
        }   else {
            self.ingredientTextField.text = ""
            self.amountDoubleTextField.text = ""
            self.priceTextField.text = ""
            
        }
            
        
//        ingredientTextField.text = ""
//        amountDoubleTextField.text = ""
//        unitTextField.text = ""
//        priceTextField.text = ""


    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "save":
            let prod = Produce()
            prod.ingredientTitle = ingredientTextField.text ?? ""
            prod.amountInDoubles = amountDoubleTextField.text ?? ""
            prod.ingredientPrice = priceTextField.text ?? ""
            
            let destination = segue.destination as! FirstViewController
            destination.produce.append(prod)
            
        case "cancel":
            print("cancel bar button item tapped")
            
        default:
            print("unexpected error")
        }
    }
}
