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
    
    var isCameraShown = true
    
    var images = [UIImage]()

//    @IBAction func cameraButton(_ sender: UIButton) {
//        
//       // var app = ClarifaiApp.init(appID: "VyvexuzVef1qsSuW_ZQyE6iUW_H1DKiWXMieAruL", appSecret: "3W8Y3AHV-26n6hbyYeJv_6uqM2vAOkpiEnN9QeFW")
//        
//        
//        
//    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.images = images
        imagePicker.dismiss(animated: true, completion: nil)
        //segue to the new Loading VC with the images and do the processing work there.
        performSegue(withIdentifier: "extractLabels", sender: self)

        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        //loadingLabel.isHidden = false
        
        self.images = images
        print(images)
        print("Done button pressed.")
        //imagePicker.dismiss(animated: true, completion: nil)
        //segue to the new Loading VC with the images and do the processing work there. 
        imagePicker.dismiss(animated: true, completion: nil)

        performSegue(withIdentifier: "extractLabels", sender: self)

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
        
        if isCameraShown == true {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        //imagePickerController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        present(imagePickerController, animated: true, completion: nil)
        isCameraShown = false
        }
        
        if isCameraShown == false {
            performSegue(withIdentifier: "extractLabels", sender: self)
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "extractLabels" {
            let vc = segue.destination as! ExtractLabelsVC
            vc.images = images
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

