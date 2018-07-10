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
            if let imageUrl = news?.urlToImage {
                let url = URL(string: imageUrl)
            
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                
                guard let data = data else {print(" image data error"); return}
                DispatchQueue.main.async {
                    
                    self.newsImage.image = UIImage(data: data)
                }
                
            }.resume()
        }
        }
    }
    
    @IBOutlet weak var newsImage: UIImageView!
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
