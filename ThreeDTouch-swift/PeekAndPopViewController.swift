//
//  PeekAndPopViewController.swift
//  ThreeDTouch-swift
//
//  Created by Han Chen on 17/6/2016.
//  Copyright © 2016年 Han Chen. All rights reserved.
//

import UIKit

class PeekAndPopViewController: UIViewController, UICollectionViewDataSource, UIViewControllerPreviewingDelegate {
  @IBOutlet weak var collectionView: UICollectionView!
  
  let image_Array = ["Helicopter", "Parachute", "Sailboat", "Spaceshuttle"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupCollectionView()
    self.setupPeekAndPop()
  }
  
  func setupCollectionView() {
    self.collectionView.backgroundColor = UIColor.whiteColor()
    self.collectionView.dataSource = self
  }
  
  // MARK: - Peek and Pop
  func setupPeekAndPop() {
    if #available(iOS 9.0, *) {
      if traitCollection.forceTouchCapability == .Available {
        registerForPreviewingWithDelegate(self, sourceView: self.view)
      }
    } else {
      // Fallback on earlier versions
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let destionationViewController: PeekAndPopDetailViewController = segue.destinationViewController as? PeekAndPopDetailViewController {
      let selectedRow = collectionView.indexPathsForSelectedItems()?.first?.row
      let imageName: String! = image_Array[selectedRow!]
      let image = UIImage(named: imageName)
      if let _ = image, _ = imageName {
        destionationViewController.setupUI(image!, text: imageName)
      }
    }
  }
  
  // MARK: - UICollectionViewDataSource
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return image_Array.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PPCell", forIndexPath: indexPath) as! PeekAndPopCell
    let image = UIImage(named: image_Array[indexPath.row])
    cell.imageView.image = image
    return cell
  }
  
  // MARK: - UIViewControllerPreviewingDelegate
  func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
    print("previewingContext(_:viewControllerForLocation:)")
    let point = CGPointMake(location.x, location.y + collectionView.contentOffset.y)
    guard let indexPath = collectionView.indexPathForItemAtPoint(point) else {
      return nil
    }
    guard let cell = collectionView.cellForItemAtIndexPath(indexPath) else {
      return nil
    }
    guard let peekAndPopDetailViewController = storyboard?.instantiateViewControllerWithIdentifier("PeekAndPopDetailViewController") as? PeekAndPopDetailViewController else {
      return nil
    }
    let imageName: String! = image_Array[indexPath.row]
    let image = UIImage(named: imageName)
    if let _ = image, _ = imageName {
      peekAndPopDetailViewController.setupUI(image!, text: imageName)
      peekAndPopDetailViewController.preferredContentSize = CGSizeMake(0, 300)
      if #available(iOS 9.0, *) {
        previewingContext.sourceRect = cell.frame
      } else {
        // Fallback on earlier versions
      }
      return peekAndPopDetailViewController
    } else {
      return nil
    }
  }
  
  func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
    print("previewingContext(_:commitViewController:)")
    showViewController(viewControllerToCommit, sender: self)
  }
}
