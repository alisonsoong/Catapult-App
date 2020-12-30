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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = self.defaults.integer(forKey:self.screenKey)


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        if (self.defaults.bool(forKey: self.settingsKey) && self.defaults.integer(forKey: self.settingsIndexKey) != 1){
            self.selectedIndex = self.defaults.integer(forKey: self.settingsIndexKey)
        }
        
        self.defaults.set(false, forKey: self.settingsKey)
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
