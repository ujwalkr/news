//
//  DropdownViewController.swift
//  News
//
//  Created by Admin on 10/07/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class DropdownViewController: UIViewController {
    
    let headerIdentifier = String(describing: HeaderView.self)
    
    let food1 = FoodType(foodName: "Food", isCollapsible: true, isCollapsed: true)
    let food2 = FoodType(foodName: "Bevrage", isCollapsible: true, isCollapsed: true)
    let food3 = FoodType(foodName: "Snack", isCollapsible: true, isCollapsed: true)
    lazy var sections: [FoodType] = [food1,food2,food3]
    
    
    let foods = ["Idli","Dosa","Uppit","Puri"]
    let bevrages = ["Mango juice","Milk shake"]
    let snacks = ["Gobi","Noodles"]
    
    var reloadSections: ((_ section: Int) -> Void)?
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = UINib(nibName: headerIdentifier, bundle: nil)
        self.tableview.register(header, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        
        reloadSections = { sections in
            self.tableview.beginUpdates()
            self.tableview.reloadSections([sections], with: .fade)
            self.tableview.endUpdates()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension DropdownViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ft = sections[section]
        switch section {
        case 0: if ft.isCollapsible,ft.isCollapsed {
                    return 0
                }else {return foods.count}
        case 1: if ft.isCollapsible,ft.isCollapsed {
                    return 0
                }else {return bevrages.count}
        case 2: if ft.isCollapsible,ft.isCollapsed {
                    return 0
                }else {return snacks.count}
        default: return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let itemCell = cell as? DropdownTableViewCell {
            switch indexPath.section {
            case 0: itemCell.item = foods[indexPath.row]
            case 1: itemCell.item = bevrages[indexPath.row]
            case 2: itemCell.item = snacks[indexPath.row]
            default: print("Not in section")
            }
        }
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return sections[section]
    //    }
    
}

extension DropdownViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! HeaderView
        header.item = sections[section]
        header.section = section
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension DropdownViewController: HeaderViewDelegate {
    func toggleSelection(header: HeaderView, section: Int) {
        let item = sections[section]
        
        if item.isCollapsible {
            let collapsed = !item.isCollapsed
            item.isCollapsed = collapsed
            header.setCollapsed(collapsed: collapsed)
            
            reloadSections?(section)
        }
    }
}

class FoodType {
    var foodName: String
    var isCollapsible: Bool
    var isCollapsed: Bool

    init(foodName: String,isCollapsible: Bool,isCollapsed: Bool){
        self.foodName = foodName
        self.isCollapsible = isCollapsible
        self.isCollapsed = isCollapsed
    }
}
