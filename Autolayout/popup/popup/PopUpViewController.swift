//
//  PopUpViewController.swift
//  popup
//
//  Created by Truth on 2018. 2. 14..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController { 
  @IBOutlet weak var popupCenterY: NSLayoutConstraint!
  @IBOutlet weak var popupImageHeight: NSLayoutConstraint!
  @IBOutlet weak var popupImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.popupCenterY.constant = 1000
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.popupCenterY.constant = 0
    
    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    let ratio = (popupImageView.image?.size.width)! / popupImageView.frame.width
    let height = (popupImageView.image?.size.height)! / ratio
    popupImageHeight.constant = height
  }
  
  @IBAction func closeBtnDidTap(_ sender: Any) {
    UIView.animate(withDuration: 0.5, animations: {
      self.view.alpha = 0
    }) { finished in
      self.dismiss(animated: false, completion: nil)
    }
  }
}
