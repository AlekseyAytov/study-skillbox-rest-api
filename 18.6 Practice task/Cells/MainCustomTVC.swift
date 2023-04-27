//
//  MainCustomTVC.swift
//  18.6 Practice task
//
//  Created by Alex Aytov on 4/24/23.
//

import UIKit

class MainCustomTVC: UITableViewCell {
    
    static let identifier = "MyCusomCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
