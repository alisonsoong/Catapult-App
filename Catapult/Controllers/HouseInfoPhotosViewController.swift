//
//  HouseInfoPhotosViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/27/20.
//

import UIKit

class HouseInfoPhotosViewController: UIViewController {

    @IBOutlet weak var FinishButton: UIButton!
    @IBOutlet weak var BathroomButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        FinishButton.layer.cornerRadius = FinishButton.frame.size.height / 5
        BathroomButton.layer.cornerRadius = BathroomButton.frame.size.height / 5
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
