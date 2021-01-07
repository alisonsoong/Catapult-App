//
//  PreviewCell.swift
//  Catapult
//
//  Created by Alison Soong on 1/6/21.
//

import UIKit

class PreviewCell: UITableViewCell {

    @IBOutlet weak var ImagePreview: UIImageView!
    @IBOutlet weak var DeleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
