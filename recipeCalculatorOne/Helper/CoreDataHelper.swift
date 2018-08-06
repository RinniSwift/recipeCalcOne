//
//  CoreDataHelper.swift
//  recipeCalculatorOne
//
//  Created by Rinni Swift on 8/2/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import UIKit
import CoreData


struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        let container = NSPersistentContainer(name: "Model")

        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext

        return context
    }()


static func newProduce() -> Produce {
    let produce = NSEntityDescription.insertNewObject(forEntityName: "Produce", into: context) as! Produce
    return produce
}

static func newRecipe() -> Recipe {
    let recipe = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context) as! Recipe
    return recipe
}
    
static func saveProduce() {
    do {
        try context.save()
    } catch let error {
        print("could not save \(error.localizedDescription)")
    }
}
    
static func saveRecipe() {
    do {
        try context.save()
    } catch let error {
        print("could not save \(error.localizedDescription)")
    }
}

static func delete(prod: Produce) {
    context.delete(prod)
    
    saveProduce()
    
}
    
static func delete(rec: Recipe) {
    context.delete(rec)
    saveRecipe()
}

static func retrieveProduce() -> [Produce] {
    do {
        let fetchRequest = NSFetchRequest<Produce>(entityName: "Produce")
        let result = try context.fetch(fetchRequest)
        
        return result
    } catch let error {
        print("could not fetch \(error.localizedDescription)")
        return []
    }
}
    
static func retrieveRecipe() -> [Recipe] {
    do {
        let fetchRequests = NSFetchRequest<Recipe>(entityName: "Recipe")
        let results = try context.fetch(fetchRequests)

        return results

    } catch let error {
        print("could not fetch \(error.localizedDescription)")
        return []
    }
}
    
    
}
