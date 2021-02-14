//
//  CompleteViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/27/20.
//

import UIKit

class CompleteViewController: UIViewController {

    let defaults = UserDefaults.standard
    let screenKey = "startScreenIndex"
    let addressLine1Key = "addressLine1"
    let addressLine2Key = "addressLine2"
    let cityKey = "city"
    let stateKey = "state"
    let postalKey = "postal"
    let firstNameKey = "firstName"
    let lastNameKey = "lastName"
    let phoneKey = "phone"
    let emailKey = "email"
    let emailDomainKey = "emailDomain"
    
    @IBOutlet weak var CloseButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        CloseButton.layer.cornerRadius = CloseButton.frame.size.height / 5
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // reset everything
//        self.defaults.set("", forKey: self.addressLine1Key)
//        self.defaults.set("", forKey: self.addressLine2Key)
//        self.defaults.set("", forKey: self.cityKey)
//        self.defaults.set("", forKey: self.stateKey)
//        self.defaults.set("", forKey: self.postalKey)
//        self.defaults.set("", forKey: self.firstNameKey)
//        self.defaults.set("", forKey: self.lastNameKey)
//        self.defaults.set("", forKey: self.phoneKey)
//        self.defaults.set("", forKey: self.emailKey)
//        self.defaults.set("", forKey: self.emailDomainKey)
        
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


