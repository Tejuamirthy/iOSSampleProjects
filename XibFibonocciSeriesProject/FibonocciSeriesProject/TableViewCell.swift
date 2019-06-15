//
//  TableViewCell.swift
//  FibonocciSeriesProject
//
//  Created by Amirthy Tejeshwar on 14/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
