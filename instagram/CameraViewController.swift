//
//  CameraViewController.swift
//  instagram
//
//  Created by Skyler Ruesga on 6/29/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit
import Fusuma
import SwiftHEXColors

class CameraViewController: UIViewController, UINavigationControllerDelegate, FusumaDelegate {

    static var postedOrCancelled = false

    
    var fusuma: FusumaViewController!
    var myImage: UIImage?
    var myVideo: URL?
    var fusumaActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fusuma = FusumaViewController()
        fusuma.delegate = self
        fusuma.hasVideo = false // If you want to let the users allow to use video.

        fusumaBaseTintColor = UIColor(hexString: "#607D8B", alpha: 1.0)!
        fusumaTintColor = UIColor(hexString: "#81D4FA", alpha: 1.0)!
        fusumaBackgroundColor = UIColor(hexString: "#FAFAFA", alpha: 1.0)!
        
        self.present(fusuma, animated: true, completion: nil)
        fusumaActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CameraViewController.postedOrCancelled || !fusumaActive {
            self.present(fusuma, animated: true, completion: nil)
            fusumaActive = true
        } else if fusumaActive {
            self.tabBarController!.selectedIndex = 0
            fusumaActive = false
        }
    }
    
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        self.myImage = image
        self.performSegue(withIdentifier: "PreparePostSegue", sender: self)
        self.myImage = nil
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        self.myVideo = fileURL
        self.performSegue(withIdentifier: "PreparePostSegue", sender: self)
        self.myVideo = nil
    }
    
    func fusumaCameraRollUnauthorized() {
        
        print("Camera roll unauthorized")
        
        let alert = UIAlertController(title: "Access Requested",
                                      message: "Saving image needs to access your photo album",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { (action) -> Void in
            
            if let url = URL(string:UIApplicationOpenSettingsURLString) {
                
                UIApplication.shared.openURL(url)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destination as! PreparePostViewController
        vc.image = self.myImage
    }
}
