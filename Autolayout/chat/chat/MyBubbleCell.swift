//
//  MyBubbleCell.swift
//  chat
//
//  Created by Truth on 2018. 2. 14..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class MyBubbleCell: UITableViewCell {
  
  @IBOutlet weak var chatLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
