//
//  RevealViewController.swift
//  sidebar DIY
//
//  Created by Truth on 2018. 1. 25..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class RevealViewController: UIViewController {
  
  var contentVC: UIViewController?
  var sideVC: UIViewController?
  
  var isSideBarShowing = false
  
  let SLIDE_TIME = 0.3
  let SIDEBAR_WIDTH: CGFloat = 260
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
  }
  
  /// 초기 화면을 설정한다.
  func setupView() {
    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController {
      self.contentVC = vc
      self.addChildViewController(vc)
      self.view.addSubview(vc.view)
      vc.didMove(toParentViewController: self)
      
      let frontVC = vc.viewControllers[0] as? FrontViewController
      frontVC?.delegate = self
    }
  }
  
  /// 사이드 바의 뷰를 읽어온다.
  func getSideView() {
    if self.sideVC == nil {
      if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear") {
        self.sideVC = vc
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
        
        vc.didMove(toParentViewController: self)
        
        self.view.bringSubview(toFront: (self.contentVC?.view)!)
      }
    }
  }
  
  /// 콘텐츠 뷰에 그림자 효과를 준다.
  func setShadowEffect(shadow: Bool, offset: CGFloat) {
    if shadow == true {
      self.contentVC?.view.layer.cornerRadius = 10
      self.contentVC?.view.layer.shadowOpacity = 0.8
      self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor
      self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset)
    }
    else {
      self.contentVC?.view.layer.cornerRadius = 0
      self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
  }
  
  /// 사이드 바를 연다.
  func openSideBar(_ complete: ( () -> Void)? ) {
    /// 앞에서 정의했던 메소드들을 실행
    self.getSideView()
    self.setShadowEffect(shadow: true, offset: -2)
    
    /// 애니메이션 옵션
    let options = UIViewAnimationOptions([.curveEaseInOut, .beginFromCurrentState])
    
    /// 애니메이션 실행
    UIView.animate(
      withDuration: TimeInterval(self.SLIDE_TIME),
      delay: TimeInterval(0),
      options: options,
      animations: {
        self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH,
                                            y: 0,
                                            width: self.view.frame.width,
                                            height: self.view.frame.height)
      },
      completion: {
        if $0 == true {
          self.isSideBarShowing = true
          complete?()
        }
      }
    )
    
  }
  
  /// 사이드 바를 닫는다.
  func closeSideBar(_ complete: ( () -> Void)? ) {
    // 애니메이션 옵션을 정의한다.
    let options = UIViewAnimationOptions([.curveEaseInOut, .beginFromCurrentState])
    
    UIView.animate(
      withDuration: TimeInterval(self.SLIDE_TIME),
      delay: TimeInterval(0),
      options: options,
      animations: {
        self.contentVC?.view.frame = CGRect(x: 0,
                                            y: 0,
                                            width: self.view.frame.width,
                                            height: self.view.frame.height)
      },
      completion: {
        if $0 == true {
          self.sideVC?.view.removeFromSuperview()
          self.sideVC = nil
          
          self.isSideBarShowing = false
          
          self.setShadowEffect(shadow: false, offset: 0)
          complete?()
        }
      }
    )
  }
}
