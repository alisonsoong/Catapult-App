//
//  AddressViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/27/20.
//

import UIKit

class AddressViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let screenKey = "startScreenIndex"
//    let settingsKey = "settingsFrom"
//    let settingsIndexKey = "settingsIndex"
    let addressLine1Key = "addressLine1"
    let addressLine2Key = "addressLine2"
    let cityKey = "city"
    let stateKey = "state"
    let postalKey = "postal"
    
    @IBOutlet weak var ErrorMessage: UIView!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var addressLine1: UITextField!
    @IBOutlet weak var addressLine2: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    @IBOutlet weak var stateInput: UITextField!
    @IBOutlet weak var postalInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        NextButton.layer.cornerRadius = NextButton.frame.size.height / 5
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        ErrorMessage.isHidden = true
        
        addressLine1.text = self.defaults.string(forKey: self.addressLine1Key)
        addressLine2.text = self.defaults.string(forKey: self.addressLine2Key)
        cityInput.text = self.defaults.string(forKey: self.cityKey)
        stateInput.text = self.defaults.string(forKey: self.stateKey)
        postalInput.text = self.defaults.string(forKey: self.postalKey)
        
        addressLine1.delegate = self
        addressLine2.delegate = self
        cityInput.delegate = self
        stateInput.delegate = self
        postalInput.delegate = self
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }
    @IBAction func addressLine1Edit(_ sender: UITextField) {
        self.defaults.set(addressLine1.text, forKey: self.addressLine1Key)
        changed()
    }
    @IBAction func addressLine2Edit(_ sender: UITextField) {
        self.defaults.set(addressLine2.text, forKey: self.addressLine2Key)
        changed()
    }
    @IBAction func cityEdit(_ sender: UITextField) {
        self.defaults.set(cityInput.text, forKey: self.cityKey)
        changed()
    }
    @IBAction func stateEdit(_ sender: UITextField) {
        self.defaults.set(stateInput.text, forKey: self.stateKey)
        changed()
    }
    @IBAction func postalEdit(_ sender: UITextField) {
        self.defaults.set(postalInput.text, forKey: self.postalKey)
        changed()
    }
    
    @IBAction func NextPressed(_ sender: UIButton) {
    
    }
    @IBAction func SettingsFromAddress(_ sender: UIButton) {
//        self.defaults.set(true, forKey: self.settingsKey)
//        self.defaults.set(2, forKey: self.settingsIndexKey)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.defaults.set(1, forKey: self.screenKey)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "step2done"){
            if (self.defaults.string(forKey: self.addressLine1Key) == "" || self.defaults.string(forKey: self.addressLine1Key) == " " || self.defaults.string(forKey: self.postalKey) == "" || self.defaults.string(forKey: self.postalKey) == " " || self.defaults.string(forKey: self.cityKey) == "" || self.defaults.string(forKey: self.cityKey) == " " || self.defaults.string(forKey: self.stateKey) == "" || self.defaults.string(forKey: self.stateKey) == " "){
//                let submitErrorAlert = UIAlertController(title: "Make sure all input boxes are filled in!", message: "Please review your submission.", preferredStyle: UIAlertController.Style.alert)
//                let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//                submitErrorAlert.addAction(cancelAction)
//                self.present(submitErrorAlert, animated: true, completion: nil)
                changed()
                self.defaults.set(2, forKey: self.screenKey)
                return false
            }
        }
        // set lastSeenScreen to photos
        self.defaults.set(3, forKey: self.screenKey)
        return true
    }
    
    func changed(){
        ErrorMessage.isHidden = true


    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.defaults.set(addressLine1.text, forKey: self.addressLine1Key)
        self.defaults.set(addressLine2.text, forKey: self.addressLine2Key)
        self.defaults.set(cityInput.text, forKey: self.cityKey)
        self.defaults.set(stateInput.text, forKey: self.stateKey)
        self.defaults.set(postalInput.text, forKey: self.postalKey)
        
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
