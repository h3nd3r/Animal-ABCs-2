//
//  CollectionViewController.swift
//  Animal ABCs
//
//  Created by Sara Hender on 2/12/17.
//  Copyright © 2017 Sara Hender. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        print(#function)
        //flowLayout.invalidateLayout()
    }
    
    override var shouldAutorotate: Bool {
//        print(#function)
        flowLayout.invalidateLayout()
        return true
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
  
  func findCorrectWidth() -> CGFloat {
    var width = view.bounds.size.width
    if #available(iOS 11, *) {
      let guide = view.safeAreaLayoutGuide
      width = guide.layoutFrame.width
    }
    return width
  }
  
  func findCorrectHeight() -> CGFloat {
    var height = view.bounds.size.height
    if #available(iOS 11, *) {
      let guide = view.safeAreaLayoutGuide
      height = guide.layoutFrame.height
    }
    return height
  }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        performSegue(withIdentifier: "expandSegue", sender: indexPath.row)
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //print(#function)
        let width = findCorrectWidth()
        let height = findCorrectHeight()
        let size =  CGSize(width: floor((width - width/10)/3), height: floor((height - height/10)/3))
        flowLayout.itemSize = size
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        print(#function)
        let width = findCorrectWidth()
        let tmp = (width - flowLayout.itemSize.width*3)/6
        print("setting insets to: \(tmp)")
        return UIEdgeInsetsMake(tmp, tmp, tmp, tmp)
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        print(#function)
        let width = findCorrectWidth()
        let space = ((width - flowLayout.itemSize.width*3)/6)*2
        print("setting line space: \(space)")
        return space
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
        cell.label.text = Util.sharedInstance.letter[indexPath.row]
        cell.image.image =  UIImage(named: Util.sharedInstance.thumbs[indexPath.row])
        
        return cell
    }
}
