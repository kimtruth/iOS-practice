//
//  ListViewController.swift
//  UserDefaults
//
//  Created by Truth on 2018. 1. 26..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
  
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var gender: UISegmentedControl!
  @IBOutlet weak var married: UISwitch!
  
  @IBAction func changeGender(_ sender: UISegmentedControl) {
    let value = sender.selectedSegmentIndex
    
    let plist = UserDefaults.standard
    plist.set(value, forKey: "gender")
    plist.synchronize()
  }
  
  @IBAction func changeMarried(_ sender: UISwitch) {
    let value = sender.isOn
    
    let plist = UserDefaults.standard
    plist.set(value, forKey: "married")
    plist.synchronize()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let plist = UserDefaults.standard
    
    self.name.text = plist.string(forKey: "name")
    self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
    self.married.isOn = plist.bool(forKey: "married")
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      /// 입력이 가능한 알림창을 띄워 이름을 수정할 수 있도록 한다.
      let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
      
      /// 입력 필드 추가
      alert.addTextField() {
        /// name 레이블의 텍스트를 입력폼에 기본값으로 넣어준다.
        $0.text = self.name.text
      }
      /// 버튼 및 액션 추가
      alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
        /// 사용자가 OK 버튼을 누르면 입력 필드에 입력된 값을 저장한다.
        let value = alert.textFields?[0].text
        
        let plist = UserDefaults.standard
        plist.set(value, forKey: "name")
        plist.synchronize()
        
        // 수정된 값을 이름 레이블에도 적용한다.
        self.name.text = value
      })
      /// 알림창을 띄운다.
      self.present(alert, animated: true, completion: nil)
    }
  }
  
}
