//
//  ViewPhotoViewController.swift
//  Catapult
//
//  Created by Alison Soong on 1/2/21.
//

import UIKit

class ViewPhotoViewController: UIViewController {
    
    
    let defaults = UserDefaults.standard
    let tbdKey = "toBeDisplayedKey"
    
    @IBOutlet weak var displayImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayImage.image = getSavedImage(named: self.defaults.string(forKey: self.tbdKey) as! String)
        // Do any additional setup after loading the view.
    }
    
    func getSavedImage(named: String) -> UIImage? {
        
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
        
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
