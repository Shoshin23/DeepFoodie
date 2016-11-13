//
//  RecipesVC.swift
//  DeepFoodie
//
//  Created by Karthik Kannan on 13/11/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecipesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var recipesTableView: UITableView!
    var arrRes = [[String:AnyObject]]()
    
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
        cell.detailTextLabel?.text = dict["recipe"]?["uri"] as? String
        print(dict["recipe"]?["uri"])
        return cell
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
