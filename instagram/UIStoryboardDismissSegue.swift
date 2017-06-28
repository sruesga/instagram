//
//  UIStoryboardSegueFromTop.swift
//  instagram
//
//  Created by Skyler Ruesga on 6/28/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit

class UIStoryboardDismissSegue: UIStoryboardSegue {
    override func perform() {
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.transitionFlipFromBottom,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
        
        //
        //        src.view.superview?.addSubview(dst.view)
        //        src.dismiss(animated: true) {
        //            src.present(dst, animated: true, completion: nil)
        //        }
        //        dst.view.transform = CGAffineTransform(translationX: 0, y: -src.view.frame.size.height)
        //
        //        UIView.animate(withDuration: 1.0, animations: {
        //            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        //
        //        }) { (finished: Bool) in
        //            src.present(dst, animated: false, completion: nil)
        //        }
    }
}
