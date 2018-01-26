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
  }
  
  @IBAction func changeMarried(_ sender: UISwitch) {
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
      })
      /// 알림창을 띄운다.
      self.present(alert, animated: true, completion: nil)
    }
  }
  
}
