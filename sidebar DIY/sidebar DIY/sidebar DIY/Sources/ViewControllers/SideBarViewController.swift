//
//  SideBarViewController.swift
//  sidebar DIY
//
//  Created by Truth on 2018. 1. 25..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class SideBarViewController: UITableViewController {
  
  var delegate: RevealViewController?
  
  /// 메뉴 제목 배열
  let titles = [
    "메뉴 01",
    "메뉴 02",
    "메뉴 03",
    "메뉴 04",
    "메뉴 05",
  ]
  
  /// 메뉴 아이콘 배열
  let icons = [
    UIImage(named: "icon01.png"),
    UIImage(named: "icon02.png"),
    UIImage(named: "icon03.png"),
    UIImage(named: "icon04.png"),
    UIImage(named: "icon05.png"),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let accountLabel = UILabel()
    accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
    accountLabel.text = "kimtruth"
    accountLabel.textColor = .white
    accountLabel.font = UIFont.boldSystemFont(ofSize: 15)
    
    let view = UIView()
    view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
    view.backgroundColor = .brown
    view.addSubview(accountLabel)
    
    self.tableView.tableHeaderView = view
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.titles.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let id = "menucell"
    let cell = tableView.dequeueReusableCell(withIdentifier: id) ??
                  UITableViewCell(style: .default, reuseIdentifier: id)
    
    cell.textLabel?.text = self.titles[indexPath.row]
    cell.imageView?.image = self.icons[indexPath.row]
    
    cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 1 {
      let uv = self.storyboard?.instantiateViewController(withIdentifier: "Second")
      let target = self.delegate?.contentVC as! UINavigationController
      target.pushViewController(uv!, animated: true)
      self.delegate?.closeSideBar(nil)
    }
  }
}
