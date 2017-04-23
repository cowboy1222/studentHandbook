//
//  TableViewCell.swift
//  studentHandbook
//
//  Created by Rengar Tsoi on 23/4/2017.
//  Copyright © 2017年 Rengar Tsoi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var attDate: UILabel!
    
    @IBOutlet weak var stdClass: UILabel!
    
    @IBOutlet weak var stdName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
