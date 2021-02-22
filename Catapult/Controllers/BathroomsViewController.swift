//
//  BathroomsViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/28/20.
//

import UIKit
import CoreData

class BathroomsViewController: UIViewController, UINavigationControllerDelegate {

    let defaults = UserDefaults.standard
    let categoryKey = "photoCategory"
    let bathroomPhotosKey = "bathroomPhotoPaths"
    let bathroomFolderKey = "bathroomFolder"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var AddPhotosButton: UIButton!
    @IBOutlet weak var TakePhotosButton: UIButton!
    @IBOutlet weak var testingImage: UIImageView!
    
    @IBOutlet weak var photoTableView: PreviewPhotosTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.photoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "imageListCell")
//        self.photoTableView.delegate = self
//        self.photoTableView.dataSource = self
//        self.photoTableView.reloadData()
        
        
        AddPhotosButton.layer.cornerRadius = AddPhotosButton.frame.size.height / 5
        TakePhotosButton.layer.cornerRadius = TakePhotosButton.frame.size.height / 5
        // Do any additional setup after loading the view.
        self.defaults.set("bathroom", forKey: self.categoryKey)



    }
    
//    let sections = [1, 1]
//
//    let image = UIImage(named: "logo")
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "imageListCell", for: indexPath) as! ImageTableViewCell
//
//        let Images = UIImage(named: "Logo")
//
//        cell.cellImageView.image=Images
//
//        return cell
//
//    }
    
    
 
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        self.defaults.set("", forKey: self.categoryKey)
    }
    @IBAction func takePictureButtonPressed(_ sender: UIButton) {
        
        
        
        self.defaults.set("bathroom", forKey: self.categoryKey)
        
        
    }
    
    @IBAction func AddPhotosPressed(_ sender: UIButton) {
    }
    
    @IBAction func TakePhotosPressed(_ sender: UIButton) {
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
