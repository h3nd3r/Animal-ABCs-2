//
//  View.swift
//  Animal ABCs
//
//  Created by Sara Hender on 2/13/17.
//  Copyright © 2017 Sara Hender. All rights reserved.
//

import UIKit

class View: UIView {
    @IBOutlet weak var letters: UILabel!
    @IBOutlet weak var animal: UILabel!
    @IBOutlet weak var picture: UIImageView!
  
    func update(_ count: Int) {
        picture.image = UIImage(named: Util.sharedInstance.pictures[count])
        letters.text = Util.sharedInstance.letters[count]
        animal.text = Util.sharedInstance.animals[count]
        backgroundColor = Util.sharedInstance.colors[count].hexColor
    }
}


