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
    
    // user info
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
    
    // arrays that keeps the path names for photos in different categories
    let bathroomPhotosKey = "bathroomPhotoPaths"
    let livingPhotosKey = "livingPhotosPaths"
    let exteriorPhotosKey = "exteriorPhotosPaths"
    let kitchenPhotosKey = "kitchenPhotosPath"
    let bedroomPhotosKey = "bedroomPhotosPath"
    let otherPhotosKey = "otherPhotosPath"
    
    // for creating unique paths (strings) for photos
    let bathroomIndexKey = "bathroomHighestIndex"
    let livingIndexKey = "livingHighestIndex"
    let exteriorIndexKey = "exteriorHighestIndex"
    let bedroomIndexKey = "bedroomHighestIndex"
    let otherIndexKey = "otherHighestIndex"
    let kitchenIndexKey = "kitchenHighestIndex"
    
    @IBOutlet weak var CloseButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        CloseButton.layer.cornerRadius = CloseButton.frame.size.height / 5
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // reset everything
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
        
        var photoList = [String]()
        if (self.defaults.object(forKey: self.bathroomPhotosKey) == nil){
            photoList = [String]()
            self.defaults.set([String](), forKey: self.bathroomPhotosKey)
        } else {
            photoList = self.defaults.object(forKey: self.bathroomPhotosKey) as! [String]
            self.defaults.set([String](), forKey: self.bathroomPhotosKey)
        }
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: .skipsHiddenFiles)
            for fileURL in fileURLs {
                if fileURL.pathExtension == "png" {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch  { print(error) }
        
        self.defaults.set([String](), forKey: self.bathroomPhotosKey)
        self.defaults.set([String](), forKey: self.livingPhotosKey)
        self.defaults.set([String](), forKey: self.exteriorPhotosKey)
        self.defaults.set([String](), forKey: self.kitchenPhotosKey)
        self.defaults.set([String](), forKey: self.bedroomPhotosKey)
        self.defaults.set([String](), forKey: self.otherPhotosKey)
        
        self.defaults.set(0, forKey: self.bathroomIndexKey)
        self.defaults.set(0, forKey: self.livingIndexKey)
        self.defaults.set(0, forKey: self.exteriorIndexKey)
        self.defaults.set(0, forKey: self.bedroomIndexKey)
        self.defaults.set(0, forKey: self.kitchenIndexKey)
        self.defaults.set(0, forKey: self.otherIndexKey)
        
    }
    

}


