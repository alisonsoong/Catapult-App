//
//  Step1ViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/27/20.
//

import UIKit

class Step1ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let screenKey = "startScreenIndex"
    let settingsKey = "settingsFrom"
    let settingsIndexKey = "settingsIndex"
    let firstNameKey = "firstName"
    let lastNameKey = "lastName"
    let phoneKey = "phone"
    let emailKey = "email"
    let emailDomainKey = "emailDomain"

    @IBOutlet weak var DoneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        DoneButton.layer.cornerRadius = DoneButton.frame.size.height / 5
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        
        if (self.defaults.bool(forKey: self.settingsKey) && self.defaults.integer(forKey: self.settingsIndexKey) != 1){
            self.navigationController?.tabBarController?.selectedIndex = self.defaults.integer(forKey: self.settingsIndexKey)
        }
        
        self.defaults.set(false, forKey: self.settingsKey)
    }
    
    @IBAction func DoneButtonPressed(_ sender: UIButton) {
        
        // set lastSeenScreen to address
        self.defaults.set(2, forKey: self.screenKey)
        
    }
    
    @IBAction func SettingsFromStep1(_ sender: UIButton) {
        self.defaults.set(true, forKey: self.settingsKey)
        self.defaults.set(1, forKey: self.settingsIndexKey)
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
