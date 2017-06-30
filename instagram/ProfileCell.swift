//
//  ProfileCell.swift
//  instagram
//
//  Created by Skyler Ruesga on 6/30/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileCell: UICollectionViewCell {
    
    @IBOutlet weak var image: PFImageView!
    
    var instagramPost: PFObject!
    
    public func clear() {
        self.image.file = nil
    }

}
