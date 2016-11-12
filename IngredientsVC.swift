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

class IngredientsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var proper_pred = [String:Array<String>]() //get the goddamn float!
    let taboo_words = ["vegetable","juice","citrus"] //words that just dont convey any meaning. Are too generic.
    var recipes_JSON:JSON! = nil
    
    var pred = [ClarifaiOutput]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var conceptName = [String]()
        for op in pred {
           // print(op.input.inputID)
            for concept in (op.concepts) {
//                print("In the new VC")
                // print(op.input.inputID)
                // print(concept.conceptName)
                conceptName.append(concept.conceptName!)
//                print(concept.score)
                
                
            }
            proper_pred[op.input.inputID] = conceptName
            conceptName.removeAll()
        }
        //print("Proper_Pred: \(proper_pred)")
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
        
        
        for word in taboo_words {
            if let index = pred.index(of: word) {
            pred.remove(at: index)
        }
        }
        
        
        cell.textLabel?.text = pred.first
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.textLabel?.font = UIFont(name: "Avenir", size: 18.0)
    }
    

    @IBAction func getRecipeTapped(_ sender: UIButton) {
        
        let todoEndpoint: String = "https://api.edamam.com/search?q=chicken&app_id=bf407e95&app_key=4c736caf69fd27756ac3a660bf2e16f5"
        Alamofire.request(todoEndpoint).responseJSON { (resData) in
            //print(resData.result.value)
            
            if((resData.result.value) != nil) {
                self.recipes_JSON = JSON(resData.result.value!)
                print(self.recipes_JSON)
            }
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


