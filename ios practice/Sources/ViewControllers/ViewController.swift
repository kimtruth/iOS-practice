//
//  ViewController.swift
//  ios practice
//
//  Created by Truth on 2018. 1. 24..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    /// CSStepper 객체 정의
    let stepper = CSStepper()
    stepper.frame = CGRect(x: 30,  y: 100, width: 130, height: 30)
    
    /// ValueChange 이벤트가 발생하면 logging(_:) 메소드가 호출되도록
    stepper.addTarget(self, action: #selector(logging(_:)), for: .valueChanged)
    self.view.addSubview(stepper)
  }
  
  @objc func logging(_ sender: CSStepper) {
    print("현재 스테퍼의 값은 \(sender.value)입니다")
  }
}

