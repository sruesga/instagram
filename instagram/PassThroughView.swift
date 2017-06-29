//
//  PassThroughView.swift
//  instagram
//
//  Created by Skyler Ruesga on 6/29/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit



class PassThroughView: UIView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
