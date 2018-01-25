//
//  FrontViewController.swift
//  sidebar DIY
//
//  Created by Truth on 2018. 1. 25..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {
  
  var delegate: RevealViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(moveSide(_:)))
    
    self.navigationItem.leftBarButtonItem = btnSideBar
    
    let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide(_:)))
    dragLeft.edges = .left
    self.view.addGestureRecognizer(dragLeft)
    
    let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide(_:)))
    dragRight.direction = .left
    self.view.addGestureRecognizer(dragRight)
  }
  
  /// 사용자의 액션에 따라 델리게이트 메소드를 호출한다.
  @objc func moveSide(_ sender: Any) {
    if sender is UIScreenEdgePanGestureRecognizer {
      self.delegate?.openSideBar(nil)
    } else if sender is UISwipeGestureRecognizer {
      self.delegate?.closeSideBar(nil)
    } else if sender is UIBarButtonItem {
      if self.delegate?.isSideBarShowing == false {
        self.delegate?.openSideBar(nil)
      } else {
        self.delegate?.closeSideBar(nil)
      }
    }
  }
}
