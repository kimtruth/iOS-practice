//
//  ViewController.swift
//  chat
//
//  Created by Truth on 2018. 2. 14..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var inputTextView: UITextView!
  @IBOutlet weak var chatTableView: UITableView!
  @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
  @IBOutlet weak var inputViewHeight: NSLayoutConstraint!
  
  var chatData = ["hi", "hello"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    inputTextView.delegate = self
    
    chatTableView.register(UINib(nibName: "MyBubbleCell", bundle: nil), forCellReuseIdentifier: "MyBubbleCell")
    chatTableView.register(UINib(nibName: "YourBubbleCell", bundle: nil), forCellReuseIdentifier: "YourBubbleCell")
    chatTableView.delegate = self
    chatTableView.dataSource = self
    chatTableView.rowHeight = UITableViewAutomaticDimension
    
    // keyboard's notification
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShow(notification:)),
                                           name: .UIKeyboardWillShow,
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide(notification:)),
                                           name: .UIKeyboardWillHide,
                                           object: nil)
  }
  @objc func keyboardWillShow(notification: NSNotification) {
    let notiInfo = notification.userInfo! as NSDictionary
    let keyboardFrame = notiInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
    let duration = notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
    let height = keyboardFrame.size.height
    
    inputViewBottomMargin.constant = -height
    
    UIView.animate(withDuration: duration) {
      self.view.layoutIfNeeded()
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    let notiInfo = notification.userInfo! as NSDictionary
    let duration = notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
    
    inputViewBottomMargin.constant = 0
    
    UIView.animate(withDuration: duration) {
      self.view.layoutIfNeeded()
    }
  }
  @IBAction func sendBtnDidTap(_ sender: Any) {
    if inputTextView.hasText {
      chatData.append(inputTextView.text)
      self.chatTableView.reloadData()
      
      self.view.layoutIfNeeded()
      
      let lastIndexPath = IndexPath(row: chatData.count - 1, section: 0)
      self.chatTableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: false)
      inputTextView.text = ""
      self.textViewDidChange(inputTextView)
    }
  }
}

extension ViewController: UITextViewDelegate {
  
  func textViewDidChange(_ textView: UITextView) {
    let height = textView.contentSize.height
    if height <= 83 {
      inputViewHeight.constant = height
      self.view.layoutIfNeeded()
      textView.setContentOffset(.zero, animated: false)
    }
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.view.endEditing(true)
    
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chatData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var defaultCell: UITableViewCell
    
    if indexPath.row % 2 == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "MyBubbleCell", for: indexPath) as! MyBubbleCell
      cell.chatLabel.text = chatData[indexPath.row]
      defaultCell = cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "YourBubbleCell", for: indexPath) as! YourBubbleCell
      cell.chatLabel.text = chatData[indexPath.row]
      defaultCell = cell
    }
    
    return defaultCell
  }
}
