//
//  ViewController.swift
//  popup
//
//  Created by Truth on 2018. 2. 14..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func showBtnDidTap(_ sender: Any) {
    let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
    guard let popupVC = storyboard.instantiateViewController(withIdentifier: "popupVC") as? PopUpViewController else {
      fatalError("fail in init controller popupVC from storyboard PopUp")
    }
    popupVC.modalPresentationStyle = .overCurrentContext
    self.present(popupVC, animated: false, completion: nil)
  }
  
}

