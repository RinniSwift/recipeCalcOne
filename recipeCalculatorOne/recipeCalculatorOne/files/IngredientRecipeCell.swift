//
//  IngredientRecipeCell.swift
//  recipeCalculatorOne
//
//  Created by Rinni Swift on 8/6/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

protocol IngredientRecipeCellDelegate: class {
    func ingredientCell(_ ingredientCell: IngredientRecipeCell, checkboxTapped: UIButton, to newSelectedState: Bool)
}

class IngredientRecipeCell: UITableViewCell {
    
    weak var delegate: IngredientRecipeCellDelegate?
    
    @IBOutlet weak var ingredientAmount: UITextField!
    @IBOutlet weak var ingredientRecipeLabel: UILabel!
    
    @IBOutlet weak var checkboxButton: UIButton!
    
    @IBAction func pressCheckBox(_ checkboxButton: UIButton) {
        delegate?.ingredientCell(self, checkboxTapped: checkboxButton, to: checkboxButton.isSelected)
    }
}
