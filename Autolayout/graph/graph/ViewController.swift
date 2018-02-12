//
//  ViewController.swift
//  graph
//
//  Created by Truth on 2018. 2. 12..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var graph1Height: NSLayoutConstraint!
  @IBOutlet weak var graph2Height: NSLayoutConstraint!
  @IBOutlet weak var graph3Height: NSLayoutConstraint!
  @IBOutlet weak var graph4Height: NSLayoutConstraint!
  @IBOutlet weak var graph5Height: NSLayoutConstraint!
  @IBOutlet weak var graph6Height: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func changeBtnDidTap(_ sender: Any) {
    self.graph1Height = self.graph1Height.changeMultiplier(multiplier: CGFloat(drand48()))
    self.graph2Height = self.graph2Height.changeMultiplier(multiplier: CGFloat(drand48()))
    self.graph3Height = self.graph3Height.changeMultiplier(multiplier: CGFloat(drand48()))
    self.graph4Height = self.graph4Height.changeMultiplier(multiplier: CGFloat(drand48()))
    self.graph5Height = self.graph5Height.changeMultiplier(multiplier: CGFloat(drand48()))
    self.graph6Height = self.graph6Height.changeMultiplier(multiplier: CGFloat(drand48()))
    
    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
  }
  
}

extension NSLayoutConstraint {
  func changeMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
    
    NSLayoutConstraint.deactivate([self])
    
    let newConstraint = NSLayoutConstraint(
      item: self.firstItem,
      attribute: self.firstAttribute,
      relatedBy: self.relation,
      toItem: self.secondItem,
      attribute: self.secondAttribute,
      multiplier: multiplier,
      constant: self.constant)
    newConstraint.priority = self.priority
    
    newConstraint.shouldBeArchived = self.shouldBeArchived
    newConstraint.identifier = self.identifier
    
    NSLayoutConstraint.activate([newConstraint])
    
    return newConstraint
  }
}
