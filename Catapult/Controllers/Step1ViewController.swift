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
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var phoneInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        DoneButton.layer.cornerRadius = DoneButton.frame.size.height / 5
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        nameInput.text = self.defaults.string(forKey: self.firstNameKey)
        lastNameInput.text = self.defaults.string(forKey: self.lastNameKey)
        phoneInput.text = self.defaults.string(forKey: self.phoneKey)
        emailInput.text = self.defaults.string(forKey: self.emailKey)
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        
        if (self.defaults.bool(forKey: self.settingsKey) && self.defaults.integer(forKey: self.settingsIndexKey) != 1){
            self.navigationController?.tabBarController?.selectedIndex = self.defaults.integer(forKey: self.settingsIndexKey)
        }
        
        self.defaults.set(false, forKey: self.settingsKey)
    }
    
    @IBAction func firstNameEdit(_ sender: UITextField) {
        self.defaults.set(nameInput.text, forKey: self.firstNameKey)
        
    }
    @IBAction func lastNameEdit(_ sender: UITextField) {
        self.defaults.set(lastNameInput.text, forKey: self.lastNameKey)
    }
    @IBAction func phoneEdit(_ sender: UITextField) {
        self.defaults.set(phoneInput.text, forKey: self.phoneKey)
    }
    
    @IBAction func emailEdit(_ sender: UITextField) {
        self.defaults.set(emailInput.text, forKey: self.emailKey)
    }
    
    @IBAction func DoneButtonPressed(_ sender: UIButton) {
        
        // set lastSeenScreen to address
        self.defaults.set(2, forKey: self.screenKey)
        
    }
    
    @IBAction func SettingsFromStep1(_ sender: UIButton) {
        self.defaults.set(true, forKey: self.settingsKey)
        self.defaults.set(1, forKey: self.settingsIndexKey)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.defaults.set(nameInput.text, forKey: self.firstNameKey)
        self.defaults.set(lastNameInput.text, forKey: self.lastNameKey)
        self.defaults.set(phoneInput.text, forKey: self.phoneKey)
        self.defaults.set(emailInput.text, forKey: self.emailKey)
        
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
