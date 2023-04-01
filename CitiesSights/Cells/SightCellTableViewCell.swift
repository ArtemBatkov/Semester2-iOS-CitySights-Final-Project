//
//  SightCellTableViewCell.swift
//  CitiesSights
//
//  Created by user233573 on 3/18/23.
//

import UIKit

class SightCellTableViewCell: UITableViewCell {

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var TitleSight: UILabel!
    
    
    @IBOutlet weak var ImageViewSight: UIImageView!
    
     
    @IBOutlet weak var ShortDescriptionSight: UILabel!
    
    
     
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
