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

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var leftArrowImageView: UIImageView!
    @IBOutlet weak var rightArrowImageView: UIImageView!
    @IBOutlet weak var dashImageView: UIImageView!
    
    var enableRepeatingAnimation = false
    var count: Int = 0
    private var slide: Int = 0
    var timer = Timer()

    private struct slide {
        var image: UIImage!
        var color: UIColor!
        var next: Any!
        var prev: Any!
        // audio
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        move()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
        move()
    }
    
    @IBAction func rightTap(_ sender: Any) {
        print(#function)
        moveLeft()
    }
    
    @IBAction func rightSwipe(_ sender: Any) {
        print(#function)
        moveRight()
    }
    
    func move() {
        print("count: \(count)")
        imageView.image = UIImage(named: Util.sharedInstance.pictures[count])
        letterLabel.text = Util.sharedInstance.letters[count]
        animalLabel.text = Util.sharedInstance.animals[count]
        self.view.backgroundColor = Util.sharedInstance.colors[count].hexColor
        hideNav()
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(showNav), userInfo: nil, repeats: false)
        Util.sharedInstance.play(count: count)
    }
    
    func moveRight() {
        print(#function)
        Util.sharedInstance.stop(count: count)
        count -= 1
        if (count == -1) {
            count = Util.sharedInstance.animals.count - 1
        }
        move()
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
        move()
    }
    
    @IBAction func tapMinimize(_ sender: Any) {
        print(#function)        
        Util.sharedInstance.stop(count: count)
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    @IBAction func pinchGesture(_ sender: UIGestureRecognizer) {
        print(#function)
        if sender.state == UIGestureRecognizerState.ended {
            Util.sharedInstance.stop(count: count)    
            performSegue(withIdentifier: "segue", sender: nil)
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

