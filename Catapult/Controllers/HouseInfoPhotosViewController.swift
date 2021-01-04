//
//  HouseInfoPhotosViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/27/20.
//

import UIKit

class HouseInfoPhotosViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let screenKey = "startScreenIndex"
    let settingsKey = "settingsFrom"
    let settingsIndexKey = "settingsIndex"
    let categoryKey = "photoCategory"
    
    @IBOutlet weak var FinishButton: UIButton!
    @IBOutlet weak var BathroomButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        FinishButton.layer.cornerRadius = FinishButton.frame.size.height / 5
        BathroomButton.layer.cornerRadius = BathroomButton.frame.size.height / 5
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if (self.defaults.string(forKey: self.categoryKey) == "bathroom") {
            self.performSegue(withIdentifier: "toBathroom", sender: self)
        }
    }
    @IBAction func bathroomButton(_ sender: UIButton) {
        self.defaults.set("bathroom", forKey: self.categoryKey)
    }
    
    @IBAction func SettingsFromPictures(_ sender: UIButton) {
        self.defaults.set(true, forKey: self.settingsKey)
        self.defaults.set(3, forKey: self.settingsIndexKey)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.defaults.set(2, forKey: self.screenKey)
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        self.defaults.set(0, forKey: self.screenKey)
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
