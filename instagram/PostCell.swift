//
//  PostCell.swift
//  instagram
//
//  Created by Skyler Ruesga on 6/28/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {

    
    @IBOutlet weak var topUsernameLabel: UILabel!
    @IBOutlet weak var captionUsernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postedImage: PFImageView!
    
    
    var instagramPost: PFObject! {
        didSet {
            self.postedImage.file = instagramPost["media"] as! PFFile
            self.postedImage.loadInBackground()
            self.topUsernameLabel.text = (instagramPost["author"] as! PFUser).username!
            self.captionUsernameLabel.text = topUsernameLabel.text
            self.captionLabel.text = instagramPost["caption"] as? String
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
