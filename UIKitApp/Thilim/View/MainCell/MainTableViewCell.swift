//
//  MainTableViewCell.swift
//  Thilim
//
//  Created by Israel Berezin on 19/02/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    var cellType : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
