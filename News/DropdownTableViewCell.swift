//
//  DropdownTableViewCell.swift
//  News
//
//  Created by Admin on 10/07/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class DropdownTableViewCell: UITableViewCell {

    var item: String? {
        didSet{
            itemName.text = self.item
        }
    }
    
    @IBOutlet weak var itemName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }

}
