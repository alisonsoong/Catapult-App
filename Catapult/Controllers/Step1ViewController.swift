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
    @IBOutlet weak var DropDownButton: UIButton!
    @IBOutlet weak var DropDownView: UIView!
    @IBOutlet weak var DomainLabel: UILabel!
    @IBOutlet weak var otherDomainInput: UITextField!
    var dropDownToggle = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DoneButton.layer.cornerRadius = DoneButton.frame.size.height / 5
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        DropDownButton.isHidden = false;
        DropDownView.isHidden = true;
        
        nameInput.text = self.defaults.string(forKey: self.firstNameKey)
        lastNameInput.text = self.defaults.string(forKey: self.lastNameKey)
        phoneInput.text = self.defaults.string(forKey: self.phoneKey)
        emailInput.text = self.defaults.string(forKey: self.emailKey)
        if (self.defaults.string(forKey: self.emailDomainKey) == "" || self.defaults.string(forKey: self.emailDomainKey) == nil){
            DomainLabel.text = "Select Domain"
            otherDomainInput.text = "";
        } else {
            DomainLabel.text = self.defaults.string(forKey: self.emailDomainKey)
            if (DomainLabel.text != "@gmail.com" && DomainLabel.text != "@yahoo.com" && DomainLabel.text != "@hotmail.com"){
                otherDomainInput.text = DomainLabel.text
            }
        }
        
        nameInput.delegate = self;
        lastNameInput.delegate = self;
        phoneInput.delegate = self;
        emailInput.delegate = self;
        otherDomainInput.delegate = self;
        
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
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
    
    
    @IBAction func DropDownPressed(_ sender: UIButton) {
        if (dropDownToggle){
            DropDownView.isHidden = true;
            dropDownToggle = false;
        } else {
            dropDownToggle = true;
            DropDownView.isHidden = false;
        }
    }
    
    @IBAction func gmailSelected(_ sender: UIButton) {
        DropDownView.isHidden = true;
        dropDownToggle = false;
        DomainLabel.text = "@gmail.com"
        self.defaults.set("@gmail.com", forKey: self.emailDomainKey)
    }
    
    @IBAction func yahooSelected(_ sender: UIButton) {
        DropDownView.isHidden = true;
        dropDownToggle = false;
        DomainLabel.text = "@yahoo.com"
        self.defaults.set("@yahoo.com", forKey: self.emailDomainKey)
    }
    
    @IBAction func hotmailSelected(_ sender: UIButton) {
        DropDownView.isHidden = true;
        dropDownToggle = false;
        DomainLabel.text = "@hotmail.com"
        self.defaults.set("@hotmail.com", forKey: self.emailDomainKey)
    }
    
    @IBAction func otherDomainInput(_ sender: UITextField) {
        DomainLabel.text = otherDomainInput.text
        self.defaults.set(otherDomainInput.text, forKey: self.emailDomainKey)
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



extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UIViewController : UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(false)
    }
    
}
