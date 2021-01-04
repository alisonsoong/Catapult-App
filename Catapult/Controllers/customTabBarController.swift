//
//  customTabBarController.swift
//  Catapult
//
//  Created by Alison Soong on 12/30/20.
//

import UIKit

class customTabBarController: UITabBarController {
    
    let defaults = UserDefaults.standard
    let screenKey = "startScreenIndex"
    let settingsKey = "settingsFrom"
    let settingsIndexKey = "settingsIndex"
    let categoryKey = "photoCategory"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        



        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        if (self.defaults.bool(forKey: self.settingsKey) && self.defaults.integer(forKey: self.settingsIndexKey) != 1){
            self.selectedIndex = self.defaults.integer(forKey: self.settingsIndexKey)
        }
        
        if (self.defaults.string(forKey: self.categoryKey) == "bathroom") {
            self.selectedIndex = 3
        }
        
        self.defaults.set(false, forKey: self.settingsKey)
        
//        self.selectedIndex = self.defaults.integer(forKey:self.screenKey)
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
