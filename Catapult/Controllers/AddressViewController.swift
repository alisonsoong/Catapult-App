//
//  AddressViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/27/20.
//

import UIKit

class AddressViewController: UIViewController {

    @IBOutlet weak var NextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        NextButton.layer.cornerRadius = NextButton.frame.size.height / 5
        // Do any additional setup after loading the view.
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
