//
//  ViewController.swift
//  DeepFoodie
//
//  Created by Karthik Kannan on 07/11/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit
import Clarifai
import ImagePicker



class ViewController: UIViewController,ImagePickerDelegate {
    
    

    //@IBOutlet weak var loadingLabel: UILabel!
    
    var pred = [String:[String:Float]]()
    var conceptName = [String]()
    var conceptScore = [Float]()
    var finalOP = [ClarifaiOutput]()

//    @IBAction func cameraButton(_ sender: UIButton) {
//        
//       // var app = ClarifaiApp.init(appID: "VyvexuzVef1qsSuW_ZQyE6iUW_H1DKiWXMieAruL", appSecret: "3W8Y3AHV-26n6hbyYeJv_6uqM2vAOkpiEnN9QeFW")
//        
//        
//        
//    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        //loadingLabel.isHidden = false
        let app = ClarifaiApp.init(appID: "VyvexuzVef1qsSuW_ZQyE6iUW_H1DKiWXMieAruL", appSecret: "3W8Y3AHV-26n6hbyYeJv_6uqM2vAOkpiEnN9QeFW")

        app?.getModelByName("food-items-v1.0", completion: { (model, error) in
            var clarifaiImgArray = [ClarifaiImage]() //initialise an array of clarifai images.
            
            for image in images {
                let img = ClarifaiImage.init(image: image)
                clarifaiImgArray.append(img!)
            }
            
            print(clarifaiImgArray.count)
            
            if error != nil {
                print("some error here.")
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok.", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                model?.predict(on: clarifaiImgArray, completion: { (output, error) in
                    if error != nil {
                        print("some error in the output \(error)")
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok.", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        self.finalOP = output!
//                        for op in output! {
//                            print("Input ID: \(op.input.inputID)")
//                        for concept in (op.concepts)! {
////                            print(concept.conceptID)
//                           // print(concept.conceptName)
//                            //print(concept.score)
//                        }
//                        }
                        

                    }
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "showIngredients", sender: self)

                    }

                })
            }
        })
        

    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //hide the extracting labels label.
        //loadingLabel.isHidden = true
        
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        //imagePickerController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        present(imagePickerController, animated: true, completion: nil)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIngredients" {
            let vc = segue.destination as! IngredientsVC
            vc.pred = finalOP
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

