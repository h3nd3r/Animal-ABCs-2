//
//  CollectionViewController.swift
//  Animal ABCs
//
//  Created by Sara Hender on 2/12/17.
//  Copyright © 2017 Sara Hender. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    // MARK: - Navigation
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController:ViewController = segue.destination as! ViewController
        viewController.count = sender as! Int
    }
    
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        performSegue(withIdentifier: "segueExpand", sender: indexPath.row)
    }
}

extension CollectionViewController: UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell : UICollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath)!
        cell.backgroundColor = UIColor.magenta
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 26
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.backgroundColor = Util.sharedInstance.colors[indexPath.row].hexColor
        cell.label.text = Util.sharedInstance.letters[indexPath.row]
        //cell.image.image =  UIImage(named: Util.sharedInstance.pictures[indexPath.row])
        
        return cell
    }
}
