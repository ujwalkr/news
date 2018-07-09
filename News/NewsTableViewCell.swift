//
//  NewsTableViewCell.swift
//  News
//
//  Created by Admin on 09/07/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    var news: News? {
        didSet {
            title.text = news?.title
            source.text = news?.source?.name
        }
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var source: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
