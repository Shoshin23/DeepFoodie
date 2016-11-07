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

    @IBAction func cameraButton(_ sender: UIButton) {
        
       // var app = ClarifaiApp.init(appID: "VyvexuzVef1qsSuW_ZQyE6iUW_H1DKiWXMieAruL", appSecret: "3W8Y3AHV-26n6hbyYeJv_6uqM2vAOkpiEnN9QeFW")
        
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)

        
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        var app = ClarifaiApp.init(appID: "VyvexuzVef1qsSuW_ZQyE6iUW_H1DKiWXMieAruL", appSecret: "3W8Y3AHV-26n6hbyYeJv_6uqM2vAOkpiEnN9QeFW")

        app?.getModelByName("food-items-v1.0", completion: { (model, error) in
            var clarifaiImg = ClarifaiImage.init(image: images.first)
            
            if error != nil {
                print("some error here.")
            }
            else {
                model?.predict(on: [clarifaiImg!], completion: { (output, error) in
                    if error != nil {
                        print("some error in the output \(error)")
                        
                    } else {
                        var op = output?[0]
                        print(op!)
                        
                        for concept in (op?.concepts)! {
                            print(concept.conceptName)
                            print(concept.score)
                        }
                        
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
        
        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

