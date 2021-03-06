//
//  BathroomsViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/28/20.
//

import UIKit
import CoreData

class BathroomsViewController: UIViewController, UITableViewDataSource, UINavigationControllerDelegate, UITableViewDelegate {
    
    

    let defaults = UserDefaults.standard
    let categoryKey = "photoCategory"
    let bathroomPhotosKey = "bathroomPhotoPaths"
    let bathroomFolderKey = "bathroomFolder"
    
    
    let photosTesting = ["img001"]
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var AddPhotosButton: UIButton!
    @IBOutlet weak var TakePhotosButton: UIButton!
    @IBOutlet weak var testingImage: UIImageView!

    @IBOutlet weak var photoTableView: UITableView!
    
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
        
        photoTableView.dataSource = self
        photoTableView.delegate = self


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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return photosTesting.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // Create an object of the dynamic cell "PlainCell"
      let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
      // Depending on the section, fill the textLabel with the relevant text
        cell.cellImageView.image = loadImageFromDocumentDirectory(nameOfImage : "img001")
        
      // Return the configured cell
      return cell

    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//
//    }
//
//
//    func tableView(_ tableView: UITableView,
//                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       // Ask for a cell of the appropriate type.
//       let cell = tableView.dequeueReusableCell(withIdentifier: "imageListCell", for: indexPath)
//
//       return cell
//    }
    
    // loads image from disk (using string file name)
    func loadImageFromDocumentDirectory(nameOfImage : String) -> UIImage {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first{
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(nameOfImage)
            let image    = UIImage(contentsOfFile: imageURL.path)
            print(imageURL.path)
            if (image == nil){
                removeImage(itemName: "image001", fileExtension: "png")
            } else {
                return image!
            }
        }
        // // backup image, failed to load image for whatever reason
        return UIImage.init(named: "image001.png")!
    }
    
    // removes image from directory given string
    func removeImage(itemName:String, fileExtension: String) {
      let fileManager = FileManager.default
      let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
      let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
      let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
      guard let dirPath = paths.first else {
          return
      }
      let filePath = "\(dirPath)/\(itemName).\(fileExtension)"
      do {
        try fileManager.removeItem(atPath: filePath)
      } catch let error as NSError {
        print(error.debugDescription)
      }}
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
