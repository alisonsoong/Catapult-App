//
//  InitialViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/26/20.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var StartButton: UIButton!
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
    let bathroomPhotosKey = "bathroomPhotoPaths"
    let livingPhotosKey = "livingPhotosPaths"
    let exteriorPhotosKey = "exteriorPhotosPaths"
    let kitchenPhotosKey = "kitchenPhotosPath"
    let bedroomPhotosKey = "bedroomPhotosPath"
    let otherPhotosKey = "otherPhotosPath"
    
    let bathroomIndexKey = "bathroomHighestIndex"
    let livingIndexKey = "livingHighestIndex"
    let exteriorIndexKey = "exteriorHighestIndex"
    let bedroomIndexKey = "bedroomHighestIndex"
    let otherIndexKey = "otherHighestIndex"
    let kitchenIndexKey = "kitchenHighestIndex"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StartButton.layer.cornerRadius = StartButton.frame.size.height / 5
        
        self.tabBarController?.tabBar.isHidden = true
        
        navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // scroll reset
//        initialScrollView.setContentOffset(CGPoint.zero, animated: true)
        
        if (self.defaults.integer(forKey:"startScreenIndex") != 0){
            self.defaults.set(0, forKey: self.screenKey)
        }
        
        // testing purposes
//        self.defaults.set("asdf", forKey: self.addressLine1Key)
//        self.defaults.set("adf", forKey: self.addressLine2Key)
//        self.defaults.set("asdf", forKey: self.cityKey)
//        self.defaults.set("asdf", forKey: self.stateKey)
//        self.defaults.set("asdf", forKey: self.postalKey)
//        self.defaults.set("asdf", forKey: self.firstNameKey)
//        self.defaults.set("asdf", forKey: self.lastNameKey)
//        self.defaults.set(123, forKey: self.phoneKey)
//        self.defaults.set("asdf", forKey: self.emailKey)
//        self.defaults.set("asdf", forKey: self.emailDomainKey)
//        self.defaults.set([String](), forKey: self.bathroomPhotosKey)
//        self.defaults.set([String](), forKey: self.livingPhotosKey)
//        self.defaults.set([String](), forKey: self.exteriorPhotosKey)
//        self.defaults.set([String](), forKey: self.kitchenPhotosKey)
//        self.defaults.set([String](), forKey: self.bedroomPhotosKey)
//        self.defaults.set([String](), forKey: self.otherPhotosKey)
        
        // reset everything
        self.defaults.set("", forKey: self.addressLine1Key)
        self.defaults.set("", forKey: self.addressLine2Key)
        self.defaults.set("", forKey: self.cityKey)
        self.defaults.set("", forKey: self.stateKey)
        self.defaults.set("", forKey: self.postalKey)
        self.defaults.set("", forKey: self.firstNameKey)
        self.defaults.set("", forKey: self.lastNameKey)
        self.defaults.set(nil, forKey: self.phoneKey)
        self.defaults.set("", forKey: self.emailKey)
        self.defaults.set("", forKey: self.emailDomainKey)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let curView  = storyBoard.instantiateViewController(withIdentifier: "Step1") as! Step1ViewController
//        self.present(curView, animated: true, completion: nil)
    }
    
    @IBAction func StartPressed(_ sender: UIButton) {
        
        // set lastSeenScreen to step 1
        self.defaults.set(1, forKey: self.screenKey)
        
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


