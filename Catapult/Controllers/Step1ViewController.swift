//
//  Step1ViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/27/20.
//

import UIKit

class Step1ViewController: UIViewController {


    @IBOutlet weak var DoneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        DoneButton.layer.cornerRadius = DoneButton.frame.size.height / 5
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func DoneButtonPressed(_ sender: UIButton) {
        
        // set lastSeenScreen to address
        
    }
    
    @IBAction func SettingsFromStep1(_ sender: UIButton) {
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
