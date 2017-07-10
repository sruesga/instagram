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
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postedImage: PFImageView!
    @IBOutlet weak var profilePicture: PFImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    
    var instagramPost: PFObject! {
        didSet {
            self.postedImage.file = instagramPost["media"] as! PFFile
            self.postedImage.loadInBackground()
            let username = (instagramPost["author"] as! PFUser).username!
            self.topUsernameLabel.text = username
            
            
            self.profilePicture.file = PFUser.current()?["profile_picture"] as? PFFile
            self.profilePicture.loadInBackground()
            self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
            self.profilePicture.clipsToBounds = true
            
            if let liked = instagramPost["liked"] as? Bool, liked == true {
                self.likeButton.setImage(UIImage(named: "redLike"), for: .normal)
            }
            
            
            if let description = instagramPost["caption"] as? String {
                self.captionLabel.attributedText = attributedString(bolded: username, normal:  description)
            }
        }
    }
    
    
    func attributedString(bolded:String, normal:String) -> NSAttributedString {
        var normalString = NSMutableAttributedString(string: " " + normal)
        
        var attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: captionLabel.font.pointSize)]
        
        var boldString = NSMutableAttributedString(string: bolded, attributes: attrs)
        
        boldString.append(normalString)
        return boldString
    }
    
    public func clear() {
        self.topUsernameLabel.text = nil
        self.postedImage.file = nil
        self.profilePicture.file = nil
        self.captionLabel.attributedText = nil
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
