//
//  HouseInfoPhotosViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/27/20.
//

import UIKit
import MessageUI
import SwiftSMTP

let smtp = SMTP(
    hostname: "smtp.gmail.com",     // SMTP server address
    // real
//    email: "submit@getcatapult.app",        // username to login
//    password: "notavailable"            // password to login
    
    // testing
    email: "asoongtesting@gmail.com",        // username to login // TODO: change email
    password: "a1s2d3f4%"            // password to login
    
    

)

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
    
    // photos
    let bathroomPhotosKey = "bathroomPhotoPaths"
    let livingPhotosKey = "livingPhotosPaths"
    let exteriorPhotosKey = "exteriorPhotosPaths"
    let kitchenPhotosKey = "kitchenPhotosPath"
    let bedroomPhotosKey = "bedroomPhotosPath"
    let otherPhotosKey = "otherPhotosPath"
    
    
    @IBOutlet weak var FinishButton: UIButton!
    @IBOutlet weak var BathroomButton: UIButton!
    @IBOutlet weak var LivingButton: UIButton!
    @IBOutlet weak var KitchenButton: UIButton!
    @IBOutlet weak var BedroomButton: UIButton!
    @IBOutlet weak var OtherButton: UIButton!
    @IBOutlet weak var ExteriorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FinishButton.layer.cornerRadius = FinishButton.frame.size.height / 5
        ExteriorButton.layer.cornerRadius = BathroomButton.frame.size.height / 5
        KitchenButton.layer.cornerRadius = BathroomButton.frame.size.height / 5
        LivingButton.layer.cornerRadius = BathroomButton.frame.size.height / 5
        BathroomButton.layer.cornerRadius = BathroomButton.frame.size.height / 5
        BedroomButton.layer.cornerRadius = BathroomButton.frame.size.height / 5
        OtherButton.layer.cornerRadius = BathroomButton.frame.size.height / 5
        
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        // go to correct last screen, TODO: add other screens in too
        if (self.defaults.string(forKey: self.categoryKey) == "bathroom") {
            self.performSegue(withIdentifier: "toBathroom", sender: self)
            
        }
        
        if (self.defaults.string(forKey: self.categoryKey) == "bedroom") {
            self.performSegue(withIdentifier: "toBedroom", sender: self)
            
        }
        
        if (self.defaults.string(forKey: self.categoryKey) == "kitchen") {
            self.performSegue(withIdentifier: "toKitchen", sender: self)
            
        }
        
        if (self.defaults.string(forKey: self.categoryKey) == "living") {
            self.performSegue(withIdentifier: "toLiving", sender: self)
            
        }
        
        if (self.defaults.string(forKey: self.categoryKey) == "other") {
            self.performSegue(withIdentifier: "toOther", sender: self)
            
        }
        
        if (self.defaults.string(forKey: self.categoryKey) == "exterior") {
            self.performSegue(withIdentifier: "toExterior", sender: self)
            
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
        
//        // alert
//        let alert = UIAlertController(title: "Review", message: "Please review your submission.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//        NSLog("The \"OK\" alert occured.")
//            // show mail to review
//            self.showMailComposer()
//        }))
//        self.present(alert, animated: true, completion: nil)
        
        // are you sure you want to submit?
        var refreshAlert = UIAlertController(title: "Submit?", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            // Handle Ok logic here
            self.submit()
        
          }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            // Handle Cancel Logic here
            
          }))

        present(refreshAlert, animated: true, completion: nil)
        
 
    }

    
    
    func submit(){
        // make email!
    
        let subjectString = "Submission, \(self.defaults.string(forKey: self.firstNameKey) ?? "Name Not Given") \(self.defaults.string(forKey: self.lastNameKey) ?? "Last Name Not Given")"
        
        let fullName = "\(self.defaults.string(forKey: self.firstNameKey) ?? "Name Not Given") \(self.defaults.string(forKey: self.lastNameKey) ?? "Last Name Not Given")"
        
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
        
        // actual message!
let bodyString = """
Contact Information

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
        
        var arrAttachments = [Attachment]()
        let fileManager = FileManager.default
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        guard let dirPath = paths.first else {
            return
        }
        
        
        var arr = [String]()
        
    
        // add exteriorPhotosKey photos
        arr = self.defaults.object(forKey: self.exteriorPhotosKey) as! [String]
        
        for x in arr {
            print(x)
            let filePath = "\(dirPath)/\(x).png"
            let fileAttachment = Attachment(filePath: filePath)
            
            if (fileManager.fileExists(atPath: filePath) && tryFile(x)) {
                arrAttachments.append(fileAttachment)
            }
        }
        
        // add livingPhotosKey photos
        arr = self.defaults.object(forKey: self.livingPhotosKey) as! [String]
        
        for x in arr {
            print(x)
            let filePath = "\(dirPath)/\(x).png"
            let fileAttachment = Attachment(filePath: filePath)
            
            if (fileManager.fileExists(atPath: filePath) && tryFile(x)) {
                arrAttachments.append(fileAttachment)
            }
        }
        
        
        // add kitchenPhotosKey photos
        arr = self.defaults.object(forKey: self.kitchenPhotosKey) as! [String]
        
        for x in arr {
            print(x)
            let filePath = "\(dirPath)/\(x).png"
            let fileAttachment = Attachment(filePath: filePath)
            
            if (fileManager.fileExists(atPath: filePath) && tryFile(x)) {
                arrAttachments.append(fileAttachment)
            }
        }
        
        // add bedroomPhotosKey photos
        arr = self.defaults.object(forKey: self.bedroomPhotosKey) as! [String]
        
        for x in arr {
            print(x)
            let filePath = "\(dirPath)/\(x).png"
            let fileAttachment = Attachment(filePath: filePath)
            
            if (fileManager.fileExists(atPath: filePath) && tryFile(x)) {
                arrAttachments.append(fileAttachment)
            }
        }
        
        // add bathroomPhotosKey photos
        arr = self.defaults.object(forKey: self.bathroomPhotosKey) as! [String]
        
        for x in arr {
            print(x)
            let filePath = "\(dirPath)/\(x).png"
            let fileAttachment = Attachment(filePath: filePath)
            
            if (fileManager.fileExists(atPath: filePath) && tryFile(x)) {
                arrAttachments.append(fileAttachment)
            }
        }
        
        // add otherPhotosKey photos
        arr = self.defaults.object(forKey: self.otherPhotosKey) as! [String]
        
        for x in arr {
            print(x)
            let filePath = "\(dirPath)/\(x).png"
            let fileAttachment = Attachment(filePath: filePath)
            
            if (fileManager.fileExists(atPath: filePath) && tryFile(x)) {
                arrAttachments.append(fileAttachment)
            }
        }
        
        // real code
//        let me = Mail.User(name: "Catapult Submissions", email: "submit@getcatapult.app") // TODO: change email
//        let user = Mail.User(name: "Catapult Submissions", email: "submit@getcatapult.app") // TODO: change email
        
        // testing purposes
        let me = Mail.User(name: "Catapult Submissions", email: "asoongtesting@gmail.com") // TODO: change email
        let user = Mail.User(name: "Catapult Submissions", email: "asoongtesting@gmail.com") // TODO: change email
        
        
        let mail = Mail(
            from: user,
            to: [me],
            subject: subjectString,
            text: bodyString,
            attachments: arrAttachments
            
        )

        smtp.send(mail) { (error) in
            if let error = error {
                print(error)
                // alert
                let alert = UIAlertController(title: "Error: Please try submitting again", message: "Please check your internet connection.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                    // show mail to review
//                    self.showMailComposer()
                }))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        
        performSegue(withIdentifier: "toCompleteScreen", sender: nil)
        
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
            composer.setToRecipients(["asoongtesting@gmail.com"]) // TODO: email change
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
    
    func tryFile(_ nameOfImage : String) -> Bool {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            if UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(nameOfImage).path) != nil {
                return true
            }
        }
        return false
    }

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
