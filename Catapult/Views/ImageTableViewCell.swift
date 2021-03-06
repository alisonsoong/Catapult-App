//
//  ImageTableViewCell.swift
//  Catapult
//
//  Created by Alison Soong on 2/21/21.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

//    @IBOutlet weak var ViewPhotoButton: UIButton!
//    @IBOutlet weak var DeletePhotoButton: UIButton!
//    @IBOutlet weak var TableImageView: UIImageView!
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellViewButton: UIButton!
    @IBOutlet weak var cellDeleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
