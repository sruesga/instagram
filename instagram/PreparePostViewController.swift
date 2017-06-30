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
    
    
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imageToPost.image = self.image
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
        UIView.animate(withDuration: 0.3) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let previewImageViewController = storyboard.instantiateViewController(withIdentifier: "PreviewImageViewController") as! PreviewImageViewController
            previewImageViewController.image = self.image
            self.addChildViewController(previewImageViewController)
            self.view.addSubview(previewImageViewController.view)
            previewImageViewController.didMove(toParentViewController: self)
        }
    }
    
    @IBAction func didTapOutsideCaption(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! PreviewImageViewController
        vc.image = self.image
    }
}
