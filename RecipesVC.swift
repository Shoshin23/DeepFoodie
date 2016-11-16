//
//  RecipesVC.swift
//  DeepFoodie
//
//  Created by Karthik Kannan on 13/11/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecipesVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var recipesTableView: UITableView!
    var arrRes = [[String:AnyObject]]()
    
    var chosenURL = String()
    var chosenLabel = String()
    
    var RecipesJSON:JSON!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let resData = RecipesJSON["hits"].arrayObject {
            self.arrRes = resData as! [[String:AnyObject]]
            //print(arrRes) //just to see how this horrendous thing looks.
        }
//        if self.arrRes.count > 0 {
//            self.recipesTableView.reloadData()
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        var dict = arrRes[indexPath.row]
        //print("DICT: \(dict)")
        cell.textLabel?.text = dict["recipe"]?["label"] as? String
        print(dict["recipe"]?["label"])
        cell.detailTextLabel?.text = dict["recipe"]?["url"] as? String
        print(dict["recipe"]?["url"])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var dict = arrRes[indexPath.row]
        chosenURL = (dict["recipe"]?["url"] as? String)!
        chosenLabel = (dict["recipe"]?["label"] as? String)!
        performSegue(withIdentifier: "showRecipe", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipe" {
            let vc = segue.destination as! displayRecipeVC
            vc.chosenLabel = chosenLabel
            vc.chosenURL = chosenURL
            
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
