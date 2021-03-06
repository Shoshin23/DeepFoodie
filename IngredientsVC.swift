//
//  IngredientsVC.swift
//  DeepFoodie
//
//  Created by Karthik Kannan on 07/11/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import Clarifai
import Alamofire
import SwiftyJSON
import Spring
import Material

class IngredientsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topLabel: SpringLabel!
    
    @IBOutlet weak var getRecipes: FlatButton!
    
   // var arrayOfIngredients = [[String]]()
    var proper_pred = [String:Array<String>]() //get the goddamn float!
    let taboo_words = ["vegetable","juice","citrus","sweet","pasture","dairy","dairy product","candy"] //words that just dont convey any meaning. Are too generic.
    var recipes_JSON:JSON! = nil
    
    var ingredients = [String?]()
    
    var editIngredients = [String]()
    
    var editedIngredient = String()
    var selectedIndex = Int()
    
    override func viewDidAppear(_ animated: Bool) {
        topLabel.isHidden = false
        topLabel.animation = "fadeIn"
        topLabel.curve = "easeIn"
        topLabel.force = 2.3
        topLabel.duration = 1.0
        topLabel.animate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options:[], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
    
    @IBAction func saveToMainViewController (_ segue:UIStoryboardSegue) {
        let detailViewController = segue.source as! EditIngredientsVC
        let index = detailViewController.index
        let modelString = detailViewController.selectedIngredient
        ingredients[index!] = modelString
        tableView.reloadData()



    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Proper_Pred: \(proper_pred)")
        //print(Array(proper_pred.values))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //conforming to the TableView protocol.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proper_pred.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var pred = Array(self.proper_pred.values)[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.textColor = UIColor.white
        for word in taboo_words { //taboo_words is an array that contains common noun-words like 'sweet', 'juice' which dont really add any meaning to the shit. I need proper nouns not common nous.
            if let index = pred.index(of: word) {
            pred.remove(at: index)
        }
        }
        ingredients.append(pred.first) //append to the ingredients array.

        cell.textLabel?.text = pred.first//take out only the very first(highest probability) term for that particular image.

        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editIngredients = Array(self.proper_pred.values)[indexPath.row]
        selectedIndex = indexPath.row
        print(editIngredients)
        //performSegue(withIdentifier: "editIngredients", sender: self)
       // self.performSegue(withIdentifier: "editIngredients", sender: self)
    }


    @IBAction func getRecipeTapped(_ sender: UIButton) {
        
        print("INGREDIENTS:\(ingredients)")
        getRecipes.title = "Hold on please"
        getRecipes.isEnabled = false
        
        
        //let queryString = "chicken"
        let queryString = (ingredients as! [String]).joined(separator: "%20")
        print(queryString)//convert it to queryString to pass on to endpoint.
        let todoEndpoint: String = "https://api.edamam.com/search?q=\(queryString)&app_id=5a766e57&app_key=1cd67b2c35c7307027efc4c6ad1f46e2"
        Alamofire.request(todoEndpoint).responseJSON { (resData) in
            //print(resData.result.value)
            
            if((resData.result.value) != nil) {
                self.recipes_JSON = JSON(resData.result.value!)
                //UserDefaults.standard.set(self.recipes_JSON, forKey: "recipesjson")

                
            }
            
            if (resData.result.error != nil) {
                let alert = UIAlertController(title: "Error", message: (resData.result.error?.localizedDescription)! + " Try once again.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok.", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                    self.getRecipes.title = "Show Recipes"
                    self.getRecipes.isEnabled = true
                    //self.tableView.reloadData()
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            
            self.performSegue(withIdentifier: "showRecipes", sender:self)
            
        }
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipes" {
            let vc = segue.destination as! RecipesVC
            if recipes_JSON != nil {
            vc.RecipesJSON = recipes_JSON
            }
        }
        
        if segue.identifier == "editIngredients" {
            let vc = segue.destination as! EditIngredientsVC
            let path = tableView.indexPathForSelectedRow
            vc.index = path?.row
            vc.pred = editIngredients
            
            
        }
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


