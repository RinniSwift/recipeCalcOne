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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindWithSegues(_ segue: UIStoryboardSegue) {
        
            }
    
}


//extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
//
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cells = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
//        cells.recipeLabel.text = "happy"
//        return cells
//    }
//
//    
//    
//    @IBAction func unwindWithSegues(_ segue: UIStoryboardSegue) {
//        
//    }
//}
