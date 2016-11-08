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

class IngredientsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var proper_pred = [String:Array<String>]() //get the goddamn float!
    
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
        let pred = Array(self.proper_pred.values)[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = pred.first
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.textLabel?.font = UIFont(name: "Avenir", size: 18.0)
    }
    

    @IBAction func getRecipeTapped(_ sender: UIButton) {
        
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        Alamofire.request(todoEndpoint).responseJSON { (resData) in
            print(resData.result.value!)
            
//            let strOutput = String(data: resData.result.value!, encoding: String.Encoding.utf8)
//            print(strOutput!)
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


