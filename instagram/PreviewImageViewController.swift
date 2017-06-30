//
//  PreviewImageViewController.swift
//  instagram
//
//  Created by Skyler Ruesga on 6/29/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit

class PreviewImageViewController: UIViewController {
    
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var previewImage: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurView.effect = blurEffect
        
        previewImage.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapOnBlurView(_ sender: Any) {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
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
