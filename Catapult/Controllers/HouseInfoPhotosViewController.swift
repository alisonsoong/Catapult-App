//
//  HouseInfoPhotosViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/27/20.
//

import UIKit
import MessageUI

class HouseInfoPhotosViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let screenKey = "startScreenIndex"
//    let settingsKey = "settingsFrom"
//    let settingsIndexKey = "settingsIndex"
    let categoryKey = "photoCategory"
    
    // step 1
    let firstNameKey = "firstName"
    let lastNameKey = "lastName"
    let phoneKey = "phone"
    let emailKey = "email"
    let emailDomainKey = "emailDomain"
    
    // step 2
    let addressLine1Key = "addressLine1"
    let addressLine2Key = "addressLine2"
    let cityKey = "city"
    let stateKey = "state"
    let postalKey = "postal"
    
    @IBOutlet weak var FinishButton: UIButton!
    @IBOutlet weak var BathroomButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        FinishButton.layer.cornerRadius = FinishButton.frame.size.height / 5
        BathroomButton.layer.cornerRadius = BathroomButton.frame.size.height / 5
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if (self.defaults.string(forKey: self.categoryKey) == "bathroom") {
            self.performSegue(withIdentifier: "toBathroom", sender: self)
            
        }
    }

    
    @IBAction func SettingsFromPictures(_ sender: UIButton) {
//        self.defaults.set(true, forKey: self.settingsKey)
//        self.defaults.set(3, forKey: self.settingsIndexKey)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.defaults.set(2, forKey: self.screenKey)
        
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        
        // alert
        let alert = UIAlertController(title: "Review", message: "Please review your submission.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
            // show mail to review
            self.showMailComposer()
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        
 
    }
    
    func showMailComposer() {
        // send email
        guard MFMailComposeViewController.canSendMail() else {
            let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check e-mail configuration and try again.", preferredStyle: UIAlertController.Style.alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            sendMailErrorAlert.addAction(cancelAction)
            self.present(sendMailErrorAlert, animated: true, completion: nil)

            return
        }
        
        if MFMailComposeViewController.canSendMail() {
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients(["alisonsoong@gmail.com"])
            let subjectString = "Submission, \(self.defaults.string(forKey: self.firstNameKey) ?? "Name Not Given") \(self.defaults.string(forKey: self.lastNameKey) ?? "Last Name Not Given")"
            composer.setSubject(subjectString)
            
            let email = self.defaults.string(forKey: self.emailKey) ?? "EmailNotGiven"
            var flag = false
            var newEmail = ""
            for char in email{
                if (char == "@"){
                    flag = true
                }
                if (char != " "){
                    newEmail += String(char)
                }
            }
            if (!flag){
                newEmail += "\(self.defaults.string(forKey: self.emailDomainKey) ?? "Email Domain Not Given")"
            }
            
            var address = "\(self.defaults.string(forKey: self.addressLine1Key) ?? "Address Not Given")"
            let second = "\(self.defaults.string(forKey: self.addressLine2Key) ?? " ")"
            if (second == " " || second == ""){
                
            } else {
                address += "\n\(second)"
            }
            
            let bodyString = """
                Submission
                    First Name: \(self.defaults.string(forKey: self.firstNameKey) ?? "First Name Not Given")
                    Last Name: \(self.defaults.string(forKey: self.lastNameKey) ?? "Last Name Not Given")
                    Phone: \(self.defaults.string(forKey: self.phoneKey) ?? "Phone Number Not Given")
                    Email: \(newEmail)
                    
                Home Information
                    Address:
                        \(address)
                        \(self.defaults.string(forKey: self.cityKey) ?? "City Not Given"), \(self.defaults.string(forKey: self.stateKey) ?? "State Not Given") \(self.defaults.string(forKey: self.postalKey) ?? "Postal Not Given")
                    
                    Pictures:
            """
                
            composer.setMessageBody(bodyString, isHTML: false)
            present(composer, animated: true)
            

        } else {
            let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check e-mail configuration and try again.", preferredStyle: UIAlertController.Style.alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            sendMailErrorAlert.addAction(cancelAction)
            self.present(sendMailErrorAlert, animated: true, completion: nil)

        }


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


//MARK: - MFMailComposeViewControllerDelegate


extension HouseInfoPhotosViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true)
        }
        
        
        controller.dismiss(animated: true)
    }
}
