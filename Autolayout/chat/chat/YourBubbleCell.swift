//
//  YourBubbleCell.swift
//  chat
//
//  Created by Truth on 2018. 2. 14..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

class YourBubbleCell: UITableViewCell {
  
  @IBOutlet weak var chatLabel: UILabel!
  @IBOutlet weak var profileImage: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
      profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
      profileImage.clipsToBounds = true
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
