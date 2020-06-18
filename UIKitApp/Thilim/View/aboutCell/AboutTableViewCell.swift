//
//  AboutTableViewCell.swift
//  Thilim
//
//  Created by Israel Berezin on 17/08/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit
enum CellType: Int {
    case Lave = 0, Memory
}

class AboutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellText: UILabel!
    var cellType: CellType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func updateCell(cellType: CellType, text:String){
        self.cellText.text = text;
        switch cellType {
        case .Lave:
            cellImage.image = #imageLiteral(resourceName: "Lav")
            break
        case .Memory:
            cellImage.image = #imageLiteral(resourceName: "gyer_png36")
            break
        default: break
            
        }
    }
}
