//
//  displayRecipeVC.swift
//  DeepFoodie
//
//  Created by Karthik Kannan on 17/11/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit

class displayRecipeVC: UIViewController {
    
    var chosenURL = String()
    var chosenLabel = String()

    @IBOutlet weak var RecipeLabel: UILabel!
    @IBOutlet weak var RecipeWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string: chosenURL)
        RecipeWebView.loadRequest(URLRequest(url: url!))
        RecipeLabel.text = chosenLabel
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
