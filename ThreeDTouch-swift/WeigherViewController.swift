//
//  WeigherViewController.swift
//  ThreeDTouch-swift
//
//  Created by Han Chen on 16/6/2016.
//  Copyright © 2016年 Han Chen. All rights reserved.
//

// http://www.appcoda.com.tw/3d-touch-tutorial/
/* touchesBegan
   touchesMoved
   touchedCancelled or touchesEnded
 */

import UIKit

class WeigherViewController: UIViewController {
  @IBOutlet weak var forceTouchArea_ImageView: UIImageView!
  @IBOutlet weak var force_Label: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let touch = touches.first {
      if #available(iOS 9.0, *) {
        if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
          // 3D Touch capable
          print("touch force: \(touch.force)")
          print("maximum possible force: \(touch.maximumPossibleForce)")
          if touch.force >= touch.maximumPossibleForce {
            force_Label.text = "over 385 g"
          } else {
            force_Label.text = "\(touch.force * 385 / touch.maximumPossibleForce) g"
          }
        }
      }
    }
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    force_Label.text = "0 g"
  }
}

