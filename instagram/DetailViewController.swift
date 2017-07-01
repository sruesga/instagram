//
//  DetailViewController.swift
//  instagram
//
//  Created by Skyler Ruesga on 6/30/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit
import ParseUI

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var imagePost: PFImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    
    var post: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imagePost.file = post["media"] as! PFFile
        self.imagePost.loadInBackground()
        self.usernameLabel.text = (post["author"] as! PFUser).username!
        self.captionLabel.text = post["caption"] as? String
        
        
        if let liked = post["liked"] as? Bool {
            self.likeButton.setImage(UIImage(named: "redLike"), for: .normal)
        }

        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        
        self.dateLabel.text = formatter.string(from: (PFUser.current()?.createdAt)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
