//
//  ViewController.swift
//  Animal ABCs
//
//  Created by Sara Hender on 1/6/17.
//  Copyright © 2017 Sara Hender. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var slideViewContainer: UIView!
    @IBOutlet weak var leftArrowImageView: UIImageView!
    @IBOutlet weak var rightArrowImageView: UIImageView!
    @IBOutlet weak var dashImageView: UIImageView!
    var slideView: View!
    
    var enableRepeatingAnimation = false
    var count: Int = 0
    private var slide: Int = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideView = UINib(nibName: "View", bundle: nil).instantiate(withOwner: View(), options:nil)[0] as! View
        slideView.update(count)
        slideViewContainer.addSubview(slideView)
    }

    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        //move()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
        move(withAnimation: false, goingRight:false)
    }
    
    @IBAction func rightTap(_ sender: Any) {
        print(#function)
        moveLeft()
    }
    
    @IBAction func rightSwipe(_ sender: Any) {
        print(#function)
        moveRight()
    }
    
    func move(withAnimation animate:Bool, goingRight right:Bool) {
        print("count: \(count)")

        if (animate) {
            let tmp = UINib(nibName: "View", bundle: nil).instantiate(withOwner: View(), options:nil)[0] as! View
            tmp.update(count)
            tmp.alpha = 0
            tmp.frame = slideViewContainer.frame
            slideViewContainer.addSubview(tmp)
            
            hideNav()
            timer.invalidate()

            let travelDistance:CGFloat = slideViewContainer.bounds.size.width + 16
            let travel:CGAffineTransform = CGAffineTransform(translationX: right ? travelDistance : -travelDistance, y: 0)
            tmp.transform = travel.inverted()
            
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: [], animations: {
                self.slideView.alpha = 0.0
                self.slideView.transform = travel
                tmp.alpha = 1.0
                tmp.transform = CGAffineTransform.identity
                
            }, completion: { (finished: Bool) in
                self.slideView.removeFromSuperview()
                self.slideView = tmp
                Util.sharedInstance.play(count: self.count)
                self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.showNav), userInfo: nil, repeats: false)
            })
        } else {
            Util.sharedInstance.play(count: self.count)
            timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(showNav), userInfo: nil, repeats: false)
        }
    }
    
    func moveRight() {
        print(#function)
        Util.sharedInstance.stop(count: count)
        count -= 1
        if (count == -1) {
            count = Util.sharedInstance.animals.count - 1
        }
        move(withAnimation: true, goingRight: true)
    }
    
    @IBAction func leftTap(_ sender: Any) {
        print(#function)
        moveRight()
    }
    
    @IBAction func leftSwipe(_ sender: Any) {
        print(#function)
        moveLeft()
    }
    
    func moveLeft() {
        print(#function)
        Util.sharedInstance.stop(count: count)
        count += 1
        if (count == Util.sharedInstance.animals.count) {
            count = 0
        }
        move(withAnimation: true, goingRight: false)
    }
    
    @IBAction func tapMinimize(_ sender: Any) {
        print(#function)        
        Util.sharedInstance.stop(count: count)
        performSegue(withIdentifier: "contractSegue", sender: nil)
    }
    
    @IBAction func pinchGesture(_ sender: UIGestureRecognizer) {
        print(#function)
        if sender.state == UIGestureRecognizerState.ended {
            Util.sharedInstance.stop(count: count)    
            performSegue(withIdentifier: "contractSegue", sender: nil)
        }
    }
    
    @IBAction func letterTap(_ sender: Any) {
        print(#function)
    }

    @IBAction func animalTap(_ sender: Any) {
        print(#function)
    }
    
    func animateNav() {
        self.leftArrowImageView.alpha = 0.1
        self.rightArrowImageView.alpha = 0.1
        self.dashImageView.alpha = 0.1
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.allowUserInteraction], animations: {
            self.leftArrowImageView.alpha = 0.75
            self.rightArrowImageView.alpha = 0.75
            self.dashImageView.alpha = 0.75
        }, completion: {finished in
            UIView.animate(withDuration: 1.0, delay: 2.0, options: [.allowUserInteraction], animations: {
                self.leftArrowImageView.alpha = 0.1
                self.rightArrowImageView.alpha = 0.1
                self.dashImageView.alpha = 0.1
            }, completion: {finished in
                if ( self.enableRepeatingAnimation ) {
                    self.perform(#selector(self.animateNav), with: self.view, afterDelay: 1.0)
                }
            })
        })
    }
    func hideNav() {
        leftArrowImageView.isHidden = true
        rightArrowImageView.isHidden = true
        dashImageView.isHidden = true
        enableRepeatingAnimation = false
    }
    
    func showNav() {
        leftArrowImageView.isHidden = false
        rightArrowImageView.isHidden = false
        dashImageView.isHidden = false
        enableRepeatingAnimation = true
        animateNav()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

