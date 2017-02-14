//
//  CollectionToSlideSegue.swift
//  Animal ABCs
//
//  Created by Sara Hender on 2/13/17.
//  Copyright © 2017 Sara Hender. All rights reserved.
//

import UIKit

class ExpandSegue: UIStoryboardSegue {

    override func perform() {
        let firstVCView = source.view as UIView!
        let thirdVCView = destination.view as UIView!
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(thirdVCView!, belowSubview: firstVCView!)
        
        thirdVCView?.transform = (thirdVCView?.transform)!.scaledBy(x: 0.001, y: 0.001)
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            firstVCView?.transform = (thirdVCView?.transform)!.scaledBy(x: 0.001, y: 0.001)
            
        }) { (Finished) -> Void in
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                thirdVCView?.transform = CGAffineTransform.identity
                
            }, completion: { (Finished) -> Void in
                
                firstVCView?.transform = CGAffineTransform.identity
                self.source.present(self.destination as UIViewController, animated: false, completion: nil)
            })
        }
        /*
        // Assign the source and destination views to local variables.
        var secondVCView = self.source.view as UIView!
        var firstVCView = self.destination.view as UIView!
        
        let screenHeight = UIScreen.main.bounds.size.height
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(firstVCView!, aboveSubview: secondVCView!)
        
        // Animate the transition.
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            firstVCView?.frame = (firstVCView?.frame.offsetBy(dx: 0.0, dy: screenHeight))!
            secondVCView?.frame = (secondVCView?.frame.offsetBy(dx: 0.0, dy: screenHeight))!
            
        }) { (Finished) -> Void in
            
            self.source.dismiss(animated: false, completion: nil)
        }        
        
        */
        /*
        // Assign the source and destination views to local variables.
        var firstVCView = self.source.view as UIView!
        var secondVCView = self.destination.view as UIView!
        
        // Get the screen width and height.
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        // Specify the initial position of the destination view.
        secondVCView?.frame = CGRect(x:0.0, y:screenHeight, width:screenWidth, height:screenHeight)
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        // Animate the transition.
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            firstVCView?.frame = (firstVCView?.frame)!.offsetBy(dx: 0.0, dy: -screenHeight)
            secondVCView?.frame = (secondVCView?.frame.offsetBy(dx: 0.0, dy: -screenHeight))!
            
        }) { (Finished) -> Void in
            self.source.present(self.destination as UIViewController,
                                                            animated: false,
                                                            completion: nil)
        }
         */
    }
}
    
