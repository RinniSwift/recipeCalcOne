//
//  Recipe.swift
//  recipeCalculatorOne
//
//  Created by Rinni Swift on 8/10/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import Foundation

extension Recipe {
    var recipeProducesArray: [RecipeProduce] {
        return (self.recipeProduces?.allObjects as! [RecipeProduce]?) ?? []
    }
}
