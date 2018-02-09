//
//  BorderButton.swift
//  Calc
//
//  Created by Truth on 2018. 2. 9..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

@IBDesignable
class BorderButton: UIButton {
  
  @IBInspectable
  public var borderWidth: CGFloat = 1.0 {
    didSet {
      self.layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable
  public var borderColor: UIColor = .gray {
    didSet {
      self.layer.borderColor = borderColor.cgColor
    }
  }
}
