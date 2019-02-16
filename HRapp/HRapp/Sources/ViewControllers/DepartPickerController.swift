//
//  DepartPickerController.swift
//  HRapp
//
//  Created by truth on 16/02/2019.
//  Copyright © 2019 kimtruth. All rights reserved.
//

import UIKit

class DepartPickerController: UIViewController {
  
  let departDAO = DepartMentDAO()
  var departList: [(departCd: Int, departTitle: String, departAddr: String)]!
  var pickerView: UIPickerView!
  
  var selectedDepartCd: Int {
    let row = self.pickerView.selectedRow(inComponent: 0)
    return self.departList[row].departCd
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.departList = self.departDAO.find()
    
    self.pickerView = UIPickerView(frame: .init(x: 0, y: 0, width: 200, height: 100))
    
    self.pickerView.dataSource = self
    self.pickerView.delegate = self
    self.view.addSubview(self.pickerView)
    
    let pWidth = self.pickerView.frame.width
    let pHeight = self.pickerView.frame.height
    
    self.preferredContentSize = .init(width: pWidth, height: pHeight)
  }
}

extension DepartPickerController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.departList.count
  }
  
}

extension DepartPickerController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let titleView = view as? UILabel ?? {
      let titleView = UILabel()
      titleView.font = .systemFont(ofSize: 14)
      titleView.textAlignment = .center
      return titleView
    }()
    
    titleView.text = "\(self.departList[row].departTitle) (\(self.departList[row].departAddr))"
    
    return titleView
  }
}
