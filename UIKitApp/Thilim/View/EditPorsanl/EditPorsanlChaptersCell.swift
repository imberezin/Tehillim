//
//  EditPorsanlChaptersCell.swift
//  Thilim
//
//  Created by Israel Berezin on 27/02/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit

class EditPorsanlChaptersCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var chapter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
