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
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var previewImage: UIImageView!

    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageToPost.image = self.image
        previewImage.image = self.image
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurView = UIVisualEffectView(effect: blurEffect)
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
                print("posting")
                
                HomeViewController.newPost = true
                self.postedOrCancelled()
            }
        }
    }
    
    @IBAction func didHitCancelButton(_ sender: Any) {
        postedOrCancelled()
    }
    
    private func postedOrCancelled() {
        CameraViewController.postedOrCancelled = true
        self.tabBarController!.selectedIndex = 0
        self.navigationController!.popToRootViewController(animated: true)
    }
    
    @IBAction func didTapPhoto(_ sender: Any) {
        displayView(blurView)
    }
    
    @IBAction func didTapOutsideCaption(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func didTapOnBlurView(_ sender: Any) {
        hideView(blurView)
    }
    
    private func displayView(_ onView: UIView) {
        onView.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: { () -> Void
            in
            onView.alpha = 1.0
            onView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        })
    }
    
    
    private func hideView(_ onView: UIView) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            onView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            onView.alpha = 0.0
        })
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/
}
