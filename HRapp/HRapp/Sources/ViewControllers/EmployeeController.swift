//
//  EmployeeController.swift
//  HRapp
//
//  Created by truth on 15/02/2019.
//  Copyright © 2019 kimtruth. All rights reserved.
//

import UIKit

class EmployeeController: UITableViewController {
  
  /// 데이터 소스를 저장할 멤버 변수
  var empList: [EmployeeVO]! {
    didSet {
      if let navTitle = self.navigationItem.titleView as? UILabel {
        navTitle.text = "사원 목록\n 총 \(self.empList.count) 명"
      }
    }
  }
  
  /// SQLite 처리를 담당할 DAO 클래스
  var empDAO = EmployeeDAO()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.empList = self.empDAO.find()
    self.setNavBar()
    
    self.tableView.tableFooterView = UIView()
    self.tableView.register(SubtitleCell.self, forCellReuseIdentifier: "empCell")
  }
  
  func setNavBar() {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(self.addButtonDidTap)
    )
    
    let navTitle = UILabel().then {
      $0.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
      $0.numberOfLines = 2
      $0.textAlignment = .center
      $0.font = .systemFont(ofSize: 14)
      $0.text = "사원 목록\n 총 \(self.empList.count) 명"
    }
    
    self.navigationItem.titleView = navTitle
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "Edit",
      style: .plain,
      target: self,
      action: #selector(self.editButtonDidTap(_:))
    )
    self.tableView.allowsSelectionDuringEditing = true
  }
  
  @objc func addButtonDidTap() {
    let alert = UIAlertController(title: "사원 등록", message: "등록할 사원 정보를 입력해 주세요", preferredStyle: .alert)
    
    alert.addTextField { (textField) in
      textField.placeholder = "사원명"
    }
    
    let pickerController = DepartPickerController()
    alert.setValue(pickerController, forKey: "contentViewController")
    
    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
    alert.addAction(UIAlertAction(title: "확인" , style: .default, handler: { (action) in
      var param = EmployeeVO()
      param.departCd = pickerController.selectedDepartCd
      param.empName = (alert.textFields?[0].text)!
      
      let df = DateFormatter()
      df.dateFormat = "yyyy-MM-dd"
      param.joinDate = df.string(from: Date())
      
      param.stateCd = .ing
      
      if self.empDAO.create(param: param) {
        self.empList = self.empDAO.find()
        self.tableView.reloadData()
      }
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  @objc func editButtonDidTap(_ sender: UIBarButtonItem) {
    print(sender)
    
    if self.isEditing == false {
      self.setEditing(true, animated: true)
      sender.title = "Done"
    } else {
      self.setEditing(false, animated: true)
      sender.title = "Edit"
    }
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "empCell", for: indexPath)
    
    let emp = self.empList[indexPath.row]
    
    cell.textLabel?.text = emp.empName + "(" + emp.stateCd.desc() + ")"
    cell.textLabel?.font = .systemFont(ofSize: 14)
    
    cell.detailTextLabel?.text = emp.departTitle
    cell.detailTextLabel?.font = .systemFont(ofSize: 12)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return self.empList.count
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    let emp = self.empList[indexPath.row]
    
    
    if self.empDAO.remove(empCd: emp.empCd) {
      self.empList.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
}
