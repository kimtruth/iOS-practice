//
//  FrontViewController.swift
//  sidebar
//
//  Created by Truth on 2018. 1. 25..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {

  // MARK: Properties
  
  @IBOutlet weak var sideBarButton: UIBarButtonItem!
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    /// 메인 컨트롤러의 참조 정보를 가져온다.
    if let revealVC = self.revealViewController() {
      /// 버튼이 클릭될 때 메인 컨트롤러에 정의된 revealToggle(_:)을 호출하도록 정의한다.
      self.sideBarButton.target = revealVC
      self.sideBarButton.action = #selector(revealVC.revealToggle(_:))
    }
    
  }
}
