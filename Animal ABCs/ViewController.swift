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
    
    var enableRepeatingAnimation = false
    var count: Int = 0
    var util: Util = Util()
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

    override func viewDidAppear(_ animated: Bool) {
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
        imageView.image = UIImage(named: util.pictures[count])
        letterLabel.text = util.letters[count]
        animalLabel.text = util.animals[count]
        self.view.backgroundColor = util.colors[count].hexColor
        hideArrows()
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(showArrows), userInfo: nil, repeats: false)
        util.play(count: count)
    }
    
    func moveRight() {
        print(#function)
        util.stop(count: count)
        count -= 1
        if (count == -1) {
            count = util.animals.count - 1
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
        util.stop(count: count)
        count += 1
        if (count == util.animals.count) {
            count = 0
        }
        move()
    }
    
    @IBAction func pinchGesture(_ sender: Any) {
        print(#function)
    }
    
    @IBAction func letterTap(_ sender: Any) {
        print(#function)
    }

    @IBAction func animalTap(_ sender: Any) {
        print(#function)
    }
    
    func animateArrows() {
        self.leftArrowImageView.alpha = 0.1
        self.rightArrowImageView.alpha = 0.1

        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.allowUserInteraction], animations: {
            self.leftArrowImageView.alpha = 0.75
            self.rightArrowImageView.alpha = 0.75
        }, completion: {finished in
            UIView.animate(withDuration: 1.0, delay: 2.0, options: [.allowUserInteraction], animations: {
                self.leftArrowImageView.alpha = 0.1
                self.rightArrowImageView.alpha = 0.1
            }, completion: {finished in
                if ( self.enableRepeatingAnimation ) {
                    self.perform(#selector(self.animateArrows), with: self.view, afterDelay: 1.0)
                }
            })
        })
    }
    func hideArrows() {
        leftArrowImageView.isHidden = true
        rightArrowImageView.isHidden = true
        enableRepeatingAnimation = false
    }
    
    func showArrows() {
        leftArrowImageView.isHidden = false
        rightArrowImageView.isHidden = false
        enableRepeatingAnimation = true
        animateArrows()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

