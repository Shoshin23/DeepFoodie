//
//  RecpiesVC.swift
//  DeepFoodie
//
//  Created by Karthik Kannan on 13/11/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecpiesVC: UIViewController {
    
    var swiftyVar:JSON!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("RecipesVC : \(swiftyVar)")
        // Do any additional setup after loading the view.
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
