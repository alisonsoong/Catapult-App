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
//    let settingsKey = "settingsFrom"
//    let settingsIndexKey = "settingsIndex"
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
    @IBOutlet weak var ErrorMessage: UIView!
    var dropDownToggle = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DoneButton.layer.cornerRadius = DoneButton.frame.size.height / 5
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        DropDownButton.isHidden = false;
        DropDownView.isHidden = true;
        ErrorMessage.isHidden = true;
        
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

    @IBAction func firstNameEdit(_ sender: UITextField) {
        self.defaults.set(nameInput.text, forKey: self.firstNameKey)
        changed()
    }
    @IBAction func lastNameEdit(_ sender: UITextField) {
        self.defaults.set(lastNameInput.text, forKey: self.lastNameKey)
        changed()
    }
    @IBAction func phoneEdit(_ sender: UITextField) {
        self.defaults.set(phoneInput.text, forKey: self.phoneKey)
        changed()
    }
    
    @IBAction func emailEdit(_ sender: UITextField) {
        self.defaults.set(emailInput.text, forKey: self.emailKey)
        changed()
    }
    
    @IBAction func DoneButtonPressed(_ sender: UIButton) {
        
        
        
        
    }
    
    @IBAction func SettingsFromStep1(_ sender: UIButton) {
//        self.defaults.set(true, forKey: self.settingsKey)
//        self.defaults.set(1, forKey: self.settingsIndexKey)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "step1done") {
            if (self.defaults.string(forKey: self.lastNameKey) == "" || self.defaults.string(forKey: self.lastNameKey) == " " || self.defaults.string(forKey: self.firstNameKey) == "" || self.defaults.string(forKey: self.firstNameKey) == " " || self.defaults.string(forKey: self.phoneKey) == nil || self.defaults.string(forKey: self.emailKey) == "" || self.defaults.string(forKey: self.emailKey) == " " || self.defaults.string(forKey: self.emailDomainKey) == "" || self.defaults.string(forKey: self.emailDomainKey) == " ") {

                
                ErrorMessage.isHidden = false
                self.defaults.set(1, forKey: self.screenKey)
                return false;
                
                
            } else {
                self.defaults.set(2, forKey: self.screenKey)
            }
            
      
        }
        
        return true
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
        changed()
    }
    
    @IBAction func yahooSelected(_ sender: UIButton) {
        DropDownView.isHidden = true;
        dropDownToggle = false;
        DomainLabel.text = "@yahoo.com"
        self.defaults.set("@yahoo.com", forKey: self.emailDomainKey)
        changed()
    }
    
    @IBAction func hotmailSelected(_ sender: UIButton) {
        DropDownView.isHidden = true;
        dropDownToggle = false;
        DomainLabel.text = "@hotmail.com"
        self.defaults.set("@hotmail.com", forKey: self.emailDomainKey)
        changed()
    }
    
    @IBAction func otherDomainInput(_ sender: UITextField) {
        DomainLabel.text = otherDomainInput.text
        self.defaults.set(otherDomainInput.text, forKey: self.emailDomainKey)
        if (otherDomainInput.text == ""){
            DomainLabel.text = "Select Domain"
        }
        changed()
    }
    
    func changed(){
        ErrorMessage.isHidden = true
    }
    

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
