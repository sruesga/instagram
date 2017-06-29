//
//  SignUpViewController.swift
//  instagram
//
//  Created by Skyler Ruesga on 6/28/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func didSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.email = emailField.text!
        newUser.username = usernameField.text!
        newUser.password = passwordField.text!
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("Yay!! Created a user.")
                self.performSegue(withIdentifier: "loginFromSignUpSegue", sender: nil)
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func didDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOutsideTextField(_ sender: Any) {
        view.endEditing(true)
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
