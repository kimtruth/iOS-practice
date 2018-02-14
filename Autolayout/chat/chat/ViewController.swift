//
//  ViewController.swift
//  chat
//
//  Created by Truth on 2018. 2. 14..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var chatTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    chatTableView.register(UINib(nibName: "MyBubbleCell", bundle: nil), forCellReuseIdentifier: "MyBubbleCell")
    chatTableView.register(UINib(nibName: "YourBubbleCell", bundle: nil), forCellReuseIdentifier: "YourBubbleCell")
    chatTableView.delegate = self
    chatTableView.dataSource = self
    chatTableView.rowHeight = UITableViewAutomaticDimension
  }
  
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell: UITableViewCell
    
    if indexPath.row % 2 == 0 {
      cell = tableView.dequeueReusableCell(withIdentifier: "MyBubbleCell", for: indexPath) as! MyBubbleCell
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: "YourBubbleCell", for: indexPath) as! YourBubbleCell
    }
    
    return cell
  }
}
