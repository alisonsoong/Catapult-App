//
//  ImageTableViewCell.swift
//  Catapult
//
//  Created by Alison Soong on 2/21/21.
//

import UIKit

protocol ImageTableViewCellDelegate: AnyObject {
    func deleteButtonPressed(with row: Int)
    func viewButtonPressed(with row: Int)
}

class ImageTableViewCell: UITableViewCell {

    var row : Int = -1
    
    weak var delegate : ImageTableViewCellDelegate?
    
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
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        self.delegate?.deleteButtonPressed(with: row)
    }
    
    @IBAction func viewButtonPressed(_ sender: UIButton) {
        self.delegate?.viewButtonPressed(with: row)
    }
    
}
