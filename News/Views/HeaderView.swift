//
//  HeaderView.swift
//  News
//
//  Created by Admin on 10/07/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var indicator: UILabel!
    
    var item: FoodType? {
        didSet{
            guard let item = item else {return}
            
            title.text = item.foodName
            setCollapsed(collapsed: item.isCollapsed)
        }
    }
    var section: Int = 0
    weak var delegate: HeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    @objc func didTapHeader() {
        delegate?.toggleSelection(header: self,section: section)
    }
    
    func setCollapsed(collapsed: Bool) {
        indicator.rotate(collapsed ? 0.0 : .pi)
    }
}

extension UIView {
    func rotate(_ toValue: CGFloat,duration: CFTimeInterval = 0.2){
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}

protocol HeaderViewDelegate: class {
    func toggleSelection(header: HeaderView,section: Int)
}
