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
    @IBOutlet weak var postedImage: UIImageView!
    
    
    var instagramPost: PFObject! {
        didSet {
            self.postedImage.file = instagramPost["image"] as? PFFile
            self.postedImage.loadInBackground()
            self.topUsernameLabel.text = instagramPost["author"]
            self.captionUsernameLabel.text = instagramPost["author"]
            self.captionLabel.text = instagramPost["caption"]
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
