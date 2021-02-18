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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var arr: [URL] = []
        arr = self.defaults.object(forKey: self.bathroomPhotosKey) as? [URL] ?? []
        
        let size = Int(arr.count)
        print("SIZE: \(size)")
        let newIndex = size + 1
        var selectedImageTag = "Bathroom"
        selectedImageTag += String(newIndex)
        

        for val in arr {
            print("HERE ---\(val)")
        }
        
        AddPhotosButton.layer.cornerRadius = AddPhotosButton.frame.size.height / 5
        TakePhotosButton.layer.cornerRadius = TakePhotosButton.frame.size.height / 5
        // Do any additional setup after loading the view.
        self.defaults.set("bathroom", forKey: self.categoryKey)
        
        
        // setting up the photos
//        let container = appDelegate.persistentContainer
//        let context = container.viewContext
//        let entity = Image(context: context)
//        entity.filePath = filePath.path
//
//        appDelegate.saveContext()
//
        fetchData()
        
        


    }
    
    func fetchData(){
        
        
        let container = appDelegate.persistentContainer
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<Image>(entityName: "Image")
        
        print("___________START____________")
        var arr: [URL] = []
        arr = self.defaults.object(forKey: self.bathroomPhotosKey) as? [URL] ?? []
    
        
    
        if (arr.count > 0){
            for filePath in arr {
                print("FILE_ PATH_________")
                print(filePath)
                print(")______ ___________")
                do {
                    let images = try context.fetch(fetchRequest)
                    
                    for image in images {
                        if let placement = image.placement, let filePath = image.filePath {
                            if FileManager.default.fileExists(atPath: filePath){
                                if let contentsOfFilePath = UIImage(contentsOfFile: filePath) {
                                    if let im = contentsOfFilePath as? UIImage {
                                        testingImage.image = im
                                        print(filePath)
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print("entered catch for image fetch request")
                }
            }
        }
        
        
        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

