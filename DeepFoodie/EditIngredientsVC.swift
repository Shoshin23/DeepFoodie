//
//  EditIngredientsVC.swift
//  DeepFoodie
//
//  Created by Karthik Kannan on 20/11/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit

class EditIngredientsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var pred = [String]()
    var selectedIngredient = String()
    var index:Int?



    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("All the ingredients from EditIngredients: \(pred)")
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return pred.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredient = pred[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = ingredient
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIngredient = pred[indexPath.row]
        performSegue(withIdentifier: "newIngredients", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newIngredients" {
            let vc = segue.destination as! IngredientsVC
            vc.editedIngredient = selectedIngredient
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
