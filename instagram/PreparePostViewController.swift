//
//  PhotoMapViewController.swift
//  instagram
//
//  Created by Skyler Ruesga on 6/28/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit

class PreparePostViewController: UIViewController {

    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var captionToPost: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didHitPostButton(_ sender: Any) {
        Post.postUserImage(image: imageToPost.image, withCaption: captionToPost.text) { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if success {
                self.imageToPost.image = nil
                self.captionToPost.text = nil
 
                let nav = self.tabBarController?.viewControllers?[0] as! UINavigationController
                let vc = nav.viewControllers[0] as! HomeViewController
                vc.loadData()
                self.tabBarController?.selectedViewController = nav
            }
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
  
    }*/
}
