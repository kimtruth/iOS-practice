//
//  DepartController.swift
//  HRapp
//
//  Created by truth on 15/02/2019.
//  Copyright © 2019 kimtruth. All rights reserved.
//

import UIKit

class DepartController: UITableViewController {
  
  var departList: [(departCd: Int, departTitle: String, departAddr: String)]!
  let departDAO = DepartMentDAO()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.departList = self.departDAO.find()
    self.setNavBar()
    
    self.tableView.tableFooterView = UIView()
    self.tableView.register(SubtitleCell.self, forCellReuseIdentifier: "departCell")
    
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
      $0.text = "부서 목록\n 총 \(self.departList.count) 개"
    }
    
    self.navigationItem.titleView = navTitle
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .edit,
      target: self,
      action: #selector(self.editButtonDidTap)
    )
    
    self.tableView.allowsSelectionDuringEditing = true
  }
  
  // MARK: Actions
  
  @objc func editButtonDidTap() {
    self.tableView.setEditing(true, animated: true)
  }
  @objc func addButtonDidTap() {
    let alert = UIAlertController(
      title: "신규 부서 등록",
      message: "신규 부서를 등록해주세요",
      preferredStyle: .alert
    )
    
    alert.addTextField { (textField) in
      textField.placeholder = "부서명"
    }
    alert.addTextField { (textField) in
      textField.placeholder = "주소"
    }
    
    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
      let title = alert.textFields?[0].text ?? ""
      let addr = alert.textFields?[1].text ?? ""
      
      if self.departDAO.create(title: title, addr: addr) {
        self.departList = self.departDAO.find()
        self.tableView.reloadData()
        
        let navTitle = self.navigationItem.titleView as! UILabel
        navTitle.text = "부서 목록\n 총 \(self.departList.count) 개"
      }
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return self.departList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "departCell", for: indexPath)
    
    let depart = self.departList[indexPath.row]
    
    cell.textLabel?.text = depart.departTitle
    cell.textLabel?.font = .systemFont(ofSize: 14)
    
    cell.detailTextLabel?.text = depart.departAddr
    cell.detailTextLabel?.font = .systemFont(ofSize: 12)
    
    cell.accessoryType = .disclosureIndicator
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    let depart = self.departList[indexPath.row]
    
    
    if self.departDAO.remove(departCd: depart.departCd) {
      self.departList.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
}
