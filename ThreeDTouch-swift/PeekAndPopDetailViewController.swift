//
//  PeekAndPopDetailViewController.swift
//  ThreeDTouch-swift
//
//  Created by Han Chen on 17/6/2016.
//  Copyright © 2016年 Han Chen. All rights reserved.
//

import UIKit

class PeekAndPopDetailViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var label: UILabel!
  
  private var image: UIImage?
  private var text: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if self.image != nil {
      self.imageView.image = self.image
    }
    if self.text != nil {
      self.label.text = self.text
    }
  }
  
  func setupUI(image: UIImage, text: String) {
    self.image = image
    self.text = text
  }
  
  // MARK: - Peek and Pop
  @available(iOS 9.0, *)
  override func previewActionItems() -> [UIPreviewActionItem] {
    let readAction = UIPreviewAction(title: "Read", style: .Default) { (action, controller) in
      print("Press read button.")
    }
    let unreadAction = UIPreviewAction(title: "Unread", style: .Destructive) { (action, controller) in
      print("Press unread button.")
    }
    return [readAction, unreadAction]
  }
}
