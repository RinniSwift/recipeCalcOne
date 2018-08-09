//
//  SecondViewController.swift
//  recipeCalculatorOne
//
//  Created by Rinni Swift on 7/25/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//
import Foundation
import UIKit



class SecondViewController: UIViewController {

    @IBOutlet weak var recipeTableView: UITableView!
    
    var recipe = [Recipe]() {
        didSet {
            recipeTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        
        recipe = CoreDataHelper.retrieveRecipe()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipeTableView.reloadData()
        recipe = CoreDataHelper.retrieveRecipe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedRecipe = recipe[indexPath.row]
            recipe.remove(at: indexPath.row)

            CoreDataHelper.delete(rec: selectedRecipe)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(recipe.count)
        return recipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeCell
        
        let recipesRecipe = recipe[indexPath.row]
        cells.recipeLabel.text = recipesRecipe.recipeTitle
        
        return cells
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayRecipeInformation":
            print("recipe cell tapped")
            
            guard let indexPath = recipeTableView.indexPathForSelectedRow else { return }
            let rec = recipe[indexPath.row]
            let destination = segue.destination as! DisplayRecipeViewController
            destination.rec = rec
        default:
            print("unexpected segue identifier")
        }
    }
    
    
    @IBAction func unwindWithSegues(_ segue: UIStoryboardSegue) {
        recipe = CoreDataHelper.retrieveRecipe()
    }
}
