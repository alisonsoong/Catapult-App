//
//  CompleteViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/27/20.
//

import UIKit

class CompleteViewController: UIViewController {

    @IBOutlet weak var CloseButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        CloseButton.layer.cornerRadius = CloseButton.frame.size.height / 5
        
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
