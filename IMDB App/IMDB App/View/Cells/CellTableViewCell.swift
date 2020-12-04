//
//  CellTableViewCell.swift
//  IMDB App
//
//  Created by Kashif Rizwan on 11/20/20.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
