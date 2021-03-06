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
    
    var photoList = [String]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var AddPhotosButton: UIButton!
    @IBOutlet weak var TakePhotosButton: UIButton!
    @IBOutlet weak var testingImage: UIImageView!

    @IBOutlet weak var photoTableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        AddPhotosButton.layer.cornerRadius = AddPhotosButton.frame.size.height / 5
        TakePhotosButton.layer.cornerRadius = TakePhotosButton.frame.size.height / 5
        // Do any additional setup after loading the view.
        self.defaults.set("bathroom", forKey: self.categoryKey)
        
        
        photoTableView.dataSource = self
        photoTableView.delegate = self
//        myRefreshControl.addTarget(self, action:#selector(BathroomsViewController.handleRefresh), for: .valueChanged)
//        photoTableView.refreshControl = myRefreshControl
        
        if (self.defaults.object(forKey: self.bathroomPhotosKey) == nil){
            self.photoList = [String]()
            self.defaults.set([String](), forKey: self.bathroomPhotosKey)
        } else {
            self.photoList = self.defaults.object(forKey: self.bathroomPhotosKey) as! [String]
        
            
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)

        photoTableView.reloadData()


    }
//
//    @objc func handleRefresh(){
//        self.photoTableView.reloadData()
//        self.myRefreshControl.endRefreshing()
//    }
//
    
    
    @objc func loadList(notification: NSNotification){
        //load data here
        self.photoTableView.reloadData()
    }
    
    func popoverDismissed() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async { self.photoTableView.reloadData() }
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.defaults.object(forKey: self.bathroomPhotosKey) == nil){
            self.photoList = [String]()
            self.defaults.set([String](), forKey: self.bathroomPhotosKey)
        } else {
            self.photoList = self.defaults.object(forKey: self.bathroomPhotosKey) as! [String]
        
        }
        
        photoTableView.dataSource = self
        photoTableView.delegate = self
        
        photoTableView.reloadData()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        photoTableView.dataSource = self
        photoTableView.delegate = self
        photoTableView.reloadData()
    }
 
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
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // Create an object of the dynamic cell "PlainCell"
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        // Depending on the section, fill the textLabel with the relevant text
        print(indexPath.row)
        print("PUT \(self.photoList[indexPath.row]) into place")
        cell.cellImageView.image = loadImageFromDocumentDirectory(nameOfImage: self.photoList[indexPath.row])
        
        
        cell.delegate = self
        
        // Return the configured cell
        cell.row = indexPath.row
        
        return cell

    }
 
    func loadImageFromDocumentDirectory(nameOfImage : String) -> UIImage {

        // check what is in the directory before deleting
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        if let allItems = try? FileManager.default.contentsOfDirectory(atPath: documentDirectory) {
            print(allItems)
        }
        
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(nameOfImage).path) ?? UIImage()
        }
        return UIImage()
    }
    
    func getSavedImage(named: String) -> UIImage? {
        
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
        
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
    

}

extension BathroomsViewController:  ImageTableViewCellDelegate {
    
    func viewButtonPressed(with row: Int) {
        if (row >= 0) {
            let indexPath = IndexPath(item: row, section: 0)
            let image = loadImageFromDocumentDirectory(nameOfImage: self.photoList[indexPath.row])
        
            // bring up another screen
            
            do {
                sleep(1)
            }
        }
    }
    
    
    func deleteButtonPressed(with row: Int) {
        print(photoList)
        if (row >= 0){
            print("removed: at \(row), name \(photoList[row])")
            
            removeImage(itemName: photoList[row], fileExtension: "png")
            self.photoList = self.defaults.object(forKey: self.bathroomPhotosKey) as! [String]
            photoList.remove(at: row)
            self.defaults.set(photoList, forKey: self.bathroomPhotosKey)
            
            // check what is in the directory before deleting
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentDirectory = paths[0]
            if let allItems = try? FileManager.default.contentsOfDirectory(atPath: documentDirectory) {
                print(allItems)
            }
            
            
            let indexPath = IndexPath(item: row, section: 0)
            
            self.photoTableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                sleep(1)
            }
        }
        
        
    }
   
}
