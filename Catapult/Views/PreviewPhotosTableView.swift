//
//  PreviewPhotosTableView.swift
//  Catapult
//
//  Created by Alison Soong on 1/6/21.
//

import UIKit

class PreviewPhotosTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func numberOfRows(inSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageListCell", for: indexPath) as! ImageTableViewCell

        let Images = UIImage(named: "Logo")

        cell.cellImageView.image=Images

        return cell

    }
    
    
    

}
