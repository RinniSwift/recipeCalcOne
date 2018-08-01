//
//  FirstViewController.swift
//  recipeCalculatorOne
//
//  Created by Rinni Swift on 7/25/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var produce = [Produce]() {
        
        didSet {
            tableView.reloadData()
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}



extension FirstViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            produce.remove(at: indexPath.row)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientCell
        let produceIngredients = produce[indexPath.row]
        cell.ingredientLabel.text = produceIngredients.ingredientTitle
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayIngredientInformation":
            print("ingredient cell tapped")
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let prod = produce[indexPath.row]
            let destination = segue.destination as! displayProduceViewController
            destination.prod = prod
            
        case "addIngredients":
            print("add ingredient bar button item tapped")


        default:
            print("unexpected segue identifier.")

        }

    }
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
    
    
}
