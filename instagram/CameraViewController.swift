//
//  CameraViewController.swift
//  instagram
//
//  Created by Skyler Ruesga on 6/29/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit
import CameraManager


class CameraViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var cameraView: UIView!
    
    var cameraManager: CameraManager!
    var myImage: UIImage!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        cameraManager = CameraManager()
        cameraManager.addPreviewLayerToView(self.cameraView)
        cameraManager.shouldEnableTapToFocus = true
        cameraManager.shouldEnablePinchToZoom = true
        
//        cameraManager.cameraOutputMode = .stillImage
//        cameraManager.cameraOutputQuality = .high
//        cameraManager.focusMode = .continuousAutoFocus
//        cameraManager.exposureMode = .continuousAutoExposure
//        cameraManager.flashMode = .auto
//        cameraManager.writeFilesToPhoneLibrary = true
//        cameraManager.animateShutter = false
//        cameraManager.animateCameraDeviceChange = false
    
        
        
        
        //        let vc = UIImagePickerController()
        //        vc.delegate = self
        //        vc.allowsEditing = true
        //
        //        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        //            print("Camera is available 📸")
        //            vc.sourceType = .camera
        //        } else {
        //            print("Camera 🚫 available so we will use photo library instead")
        //            vc.sourceType = .photoLibrary
        //        }
        //        self.present(vc, animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTakePhoto(_ sender: Any) {
        cameraManager.capturePictureWithCompletion { (image: UIImage?, error: Error?) in
            if let image = image {
                self.myImage = image
                self.performSegue(withIdentifier: "PreparePostSegue", sender: self)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    
    
    
//    
//    func imagePickerController(_ picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [String : Any]) {
//        // Get the image captured by the UIImagePickerController
//        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
//        
//        // Do something with the images (based on your use case)
////        imageToPost.image = editedImage
//        
//        // Dismiss UIImagePickerController to go back to your original view controller
//        dismiss(animated: true, completion: nil)
//    }
//    

    

    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destination as! PreparePostViewController
        vc.image = self.myImage
    }
}
