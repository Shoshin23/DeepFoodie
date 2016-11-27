//
//  ExtractLabelsVC.swift
//  DeepFoodie
//
//  Created by Karthik Kannan on 19/11/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

//Do majority of the extraction work here. Just send a final Array of Arrays.


import UIKit
import Clarifai
import ALThreeCircleSpinner


class ExtractLabelsVC: UIViewController {
    
    var images = [UIImage]()
    
    var pred = [String:[String:Float]]()
    var conceptName = [String]()
    var conceptScore = [Float]()
    var finalOP = [ClarifaiOutput]()
    
    var proper_pred = [String:Array<String>]()

    @IBOutlet weak var extractLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let spinner = ALThreeCircleSpinner(frame: CGRect(x:(self.view.frame.size.width/2-25), y:(self.view.frame.size.height/2-50), width:60, height:60))

        spinner.tintColor = UIColor.white
        self.view.addSubview(spinner)

        // Do any additional setup after loading the view.
        
        let app = ClarifaiApp.init(appID: "VyvexuzVef1qsSuW_ZQyE6iUW_H1DKiWXMieAruL", appSecret: "3W8Y3AHV-26n6hbyYeJv_6uqM2vAOkpiEnN9QeFW")
        
        app?.getModelByName("food-items-v1.0", completion: { (model, error) in
            var clarifaiImgArray = [ClarifaiImage]() //initialise an array of clarifai images.
            
            for image in self.images {
                let img = ClarifaiImage.init(image: image)
                clarifaiImgArray.append(img!)
            }
            
            
            //[if no images are passed on to the extract function. Mostly when they click on 'Cancel'.]
            if (clarifaiImgArray.count == 0) {
                self.extractLabel.text = "Sorry. You need to pick an image."
                self.performSegue(withIdentifier: "cameraMenu", sender: self)
            } else {
                self.extractLabel.text = "Extracting labels."
            }
            print(clarifaiImgArray.count)
            //[END]
            
            
            if error != nil {
                print("some error here.")
                
                let alert = UIAlertController(title: "Error", message: (error?.localizedDescription)! + " Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok.", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                    self.performSegue(withIdentifier: "cameraMenu", sender: self)
                    
                }))
                //alert.addAction(UIAlertAction(title: "Ok.", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                //self.performSegue(withIdentifier: "cameraMenu", sender: self) //incase of error. go back to the main menu.
                
            }
            else {
                print("Predicting shit now. ")
                model?.predict(on: clarifaiImgArray, completion: { (output, error) in
                    if error != nil {
                        print("some error in the output \(error)")
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok.", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.performSegue(withIdentifier: "cameraMenu", sender: nil) //incase of error. back to the main menu. 

                        
                    } else {
                        print(self.finalOP)
                        self.finalOP = output!
                    }
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "showIngredients", sender: self)
                        
                    }
                    
                })
            }
        })

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIngredients" {
            let vc = segue.destination as! IngredientsVC
            //vc.pred = finalOP
            var conceptName = [String]()
            for op in finalOP {
                for concept in (op.concepts) { //get 'concepts'.
                    //                print("In the new VC")
                    // print(op.input.inputID)
                    // print(concept.conceptName)
                    conceptName.append(concept.conceptName!) //append conceptNames to the conceptName array.
                    //                print(concept.score)
                    
                    
                }
                proper_pred[op.input.inputID] = conceptName //append it it to this array called proper_pred that contains the input ID along with those conceptNames. I dont need all of them but just the one with the highest probability.
                conceptName.removeAll()
            }
            
            vc.proper_pred = proper_pred

        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
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

}
