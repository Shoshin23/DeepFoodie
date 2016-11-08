//
//  IngredientsVC.swift
//  DeepFoodie
//
//  Created by Karthik Kannan on 07/11/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import Clarifai

class IngredientsVC: UIViewController {
    
    var proper_pred = [String:Any]() //get the goddamn float!
    
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
        print("Proper_Pred: \(proper_pred)")
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
