
//
//  PrayTableViewCell.swift
//  Thilim
//
//  Created by Israel Berezin on 22/02/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit

class PrayTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func updateCellIWithChapterNumber(chapterNumber:Int){
        let imageName = "t\(chapterNumber)"
        let image:UIImage = UIImage(named: imageName)!
        print(image.size.width)
        print(image.size.height)

        self.cellImage.image = image;
        self.cellImage.contentMode = .scaleAspectFit
        self.cellImage.frame = CGRect(x: 0,y: 0,width: self.frame.width,height: image.size.height/3)
        
        
    }


}

