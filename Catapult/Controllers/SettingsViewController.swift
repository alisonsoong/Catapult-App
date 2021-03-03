//
//  SettingsViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/27/20.
//

import UIKit

class SettingsViewController: UIViewController {
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        
        // are you sure you want to submit?
        let refreshAlert = UIAlertController(title: "View Page", message: "Are you sure you want to leave the app? All your progress will be saved.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            // Handle Ok logic here
            
            UIApplication.shared.open(URL(string:"https://catapult-2854f1.webflow.io/about")! as URL, options: [:], completionHandler: nil)
          }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            // Handle Cancel Logic here
            
          }))

        present(refreshAlert, animated: true, completion: nil)
        
    }
    @IBAction func FAQButtonPressed(_ sender: UIButton) {
        
        // are you sure you want to submit?
        let refreshAlert = UIAlertController(title: "View Page", message: "Are you sure you want to leave the app? All your progress will be saved.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            // Handle Ok logic here
            
            UIApplication.shared.open(URL(string:"https://catapult-2854f1.webflow.io/faqs")! as URL, options: [:], completionHandler: nil)
          }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            // Handle Cancel Logic here
            
          }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "resetSegue") {
            return false

        }

        return true
    }
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        
        var refreshAlert = UIAlertController(title: "Reset", message: "Are you sure you want to restart? All your progress will be lost.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            // Handle Ok logic here
            self.reset()

          }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            // Handle Cancel Logic here

          }))

        present(refreshAlert, animated: true, completion: nil)
        
   
        
        
        
        
    }
    
    func reset(){
        self.defaults.set("", forKey: self.addressLine1Key)
        self.defaults.set("", forKey: self.addressLine2Key)
        self.defaults.set("", forKey: self.cityKey)
        self.defaults.set("", forKey: self.stateKey)
        self.defaults.set("", forKey: self.postalKey)
        self.defaults.set("", forKey: self.firstNameKey)
        self.defaults.set("", forKey: self.lastNameKey)
        self.defaults.set("", forKey: self.phoneKey)
        self.defaults.set("", forKey: self.emailKey)
        self.defaults.set("", forKey: self.emailDomainKey)
        
        // go back to original screen
        self.defaults.set(0, forKey: self.screenKey)
        
        self.performSegue(withIdentifier: "resetSegue", sender: nil)
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
