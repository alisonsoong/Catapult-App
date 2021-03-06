//
//  GetPhotoViewController.swift
//  Catapult
//
//  Created by Alison Soong on 1/2/21.
//

import UIKit
import CoreData

class GetPhotoViewController: UIViewController {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var initialButton: UIView!
    @IBOutlet weak var reselectButton: UIButton!
    
    let defaults = UserDefaults.standard
    let categoryKey = "photoCategory"
    
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

    // etc, TODO: make the keys
    
    var curImage = UIImage()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        stack.isHidden = true
        background.isHidden = true
        reselectButton.isHidden = true
        initialButton.isHidden = false
        // Do any additional setup after loading the view.
        
        let image = UIImagePickerController()
        image.delegate = self

        image.sourceType = .photoLibrary

        image.allowsEditing = false
        self.present(image, animated:true){
            self.initialButton.isHidden = true
            self.stack.isHidden = false
            self.background.isHidden = false
            self.reselectButton.isHidden = false
        }
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
    }
    
    @IBAction func importImage(_sender: AnyObject){
        let image = UIImagePickerController()
        image.delegate = self

        image.sourceType = .photoLibrary

        image.allowsEditing = false
        self.present(image, animated:true){
            self.initialButton.isHidden = true
            self.stack.isHidden = false
            self.background.isHidden = false
            self.reselectButton.isHidden = false
        }
        
        
    }
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            imagePreview.image = image
            self.curImage = image
        }
        

    }
    
    @IBAction func usePhoto(_ sender: UIButton) {
        print("TEST 1")
        
        
        if (curImage.size.width != 0){
            saveImageToDocumentDirectory(image: curImage)
            
            // check
            print("CHECK")
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentDirectory = paths[0]
            if let allItems = try? FileManager.default.contentsOfDirectory(atPath: documentDirectory) {
                print(allItems)
            }
            print("END")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // saves image to document directory
    func saveImageToDocumentDirectory(image: UIImage ) -> Bool {
        
        var arr = [String]()
        var newIndex = -1
        var selectedImageTag = ""
        if (self.defaults.string(forKey: categoryKey) == "bathroom"){
            if (self.defaults.object(forKey: self.bathroomPhotosKey) == nil){
                arr = [String]()
                self.defaults.set([String](), forKey: self.bathroomPhotosKey)
            } else {
                arr = self.defaults.object(forKey: self.bathroomPhotosKey) as! [String]
            }
            print("TEST 2")
            newIndex = self.defaults.integer(forKey: self.bathroomIndexKey) + 1
            self.defaults.setValue(newIndex, forKey: bathroomIndexKey)
            selectedImageTag = "Bathroom"
            
            selectedImageTag += String(newIndex)
            print("TEST 3: \(selectedImageTag)")
            arr.append(selectedImageTag)
            self.defaults.set(arr, forKey: self.bathroomPhotosKey)
            
        } else if (self.defaults.string(forKey: categoryKey) == "living") {
            
            if (self.defaults.object(forKey: self.livingPhotosKey) == nil){
                arr = [String]()
                self.defaults.set([String](), forKey: self.livingPhotosKey)
            } else {
                arr = self.defaults.object(forKey: self.livingPhotosKey) as! [String]
            }
            
            newIndex = self.defaults.integer(forKey: self.livingIndexKey) + 1
            self.defaults.setValue(newIndex, forKey: livingIndexKey)
            
            selectedImageTag = "Living"
            
            selectedImageTag += String(newIndex)
            arr.append(selectedImageTag)
            self.defaults.set(arr, forKey: self.livingPhotosKey)
        
        } else if (self.defaults.string(forKey: categoryKey) == "exterior") {
            
            // change 3
            if (self.defaults.object(forKey: self.exteriorPhotosKey) == nil){
                arr = [String]()
                self.defaults.set([String](), forKey: self.exteriorPhotosKey)
            } else {
                arr = self.defaults.object(forKey: self.exteriorPhotosKey) as! [String]
            }
            
            // change 2
            newIndex = self.defaults.integer(forKey: self.exteriorIndexKey) + 1
            self.defaults.setValue(newIndex, forKey: exteriorIndexKey)
            
            // change name
            selectedImageTag = "Exterior"
            
            // change 1
            selectedImageTag += String(newIndex)
            arr.append(selectedImageTag)
            self.defaults.set(arr, forKey: self.exteriorPhotosKey)
        
        } else if (self.defaults.string(forKey: categoryKey) == "kitchen") {
            
            // change 3
            if (self.defaults.object(forKey: self.kitchenPhotosKey) == nil){
                arr = [String]()
                self.defaults.set([String](), forKey: self.kitchenPhotosKey)
            } else {
                arr = self.defaults.object(forKey: self.kitchenPhotosKey) as! [String]
            }
            
            // change 2
            newIndex = self.defaults.integer(forKey: self.kitchenIndexKey) + 1
            self.defaults.setValue(newIndex, forKey: kitchenIndexKey)
            
            // change name
            selectedImageTag = "Kitchen"
            
            // change 1
            selectedImageTag += String(newIndex)
            arr.append(selectedImageTag)
            self.defaults.set(arr, forKey: self.kitchenPhotosKey)
        
        } else if (self.defaults.string(forKey: categoryKey) == "bedroom") {
            
            // change 3
            if (self.defaults.object(forKey: self.bedroomPhotosKey) == nil){
                arr = [String]()
                self.defaults.set([String](), forKey: self.bedroomPhotosKey)
            } else {
                arr = self.defaults.object(forKey: self.bedroomPhotosKey) as! [String]
            }
            
            // change 2
            newIndex = self.defaults.integer(forKey: self.bedroomIndexKey) + 1
            self.defaults.setValue(newIndex, forKey: bedroomIndexKey)
            
            // change name
            selectedImageTag = "Bedroom"
            
            // change 1
            selectedImageTag += String(newIndex)
            arr.append(selectedImageTag)
            self.defaults.set(arr, forKey: self.bedroomPhotosKey)
        
        } else {
            // if it's other
            // change 3
            if (self.defaults.object(forKey: self.otherPhotosKey) == nil){
                arr = [String]()
                self.defaults.set([String](), forKey: self.otherPhotosKey)
            } else {
                arr = self.defaults.object(forKey: self.otherPhotosKey) as! [String]
            }
            
            // change 2
            newIndex = self.defaults.integer(forKey: self.otherIndexKey) + 1
            self.defaults.setValue(newIndex, forKey: otherIndexKey)
            
            // change name
            selectedImageTag = "Other"
            
            // change 1
            selectedImageTag += String(newIndex)
            arr.append(selectedImageTag)
            self.defaults.set(arr, forKey: self.otherPhotosKey)
        }

        print(arr)
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = selectedImageTag // name of the image to be saved
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        print(fileURL)
        
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("\(selectedImageTag).png")!)
        } catch {
            print(error.localizedDescription)
        }
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        if let allItems = try? FileManager.default.contentsOfDirectory(atPath: documentDirectory) {
            print(allItems)
        }

        print("DONE")
        return true
    }
    
    func createFile(atPath path: String,
           contents data: Data?,
           attributes attr: [FileAttributeKey : Any]? = nil) -> Bool {
        return true
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension GetPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        if (curImage == UIImage()){
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }

        curImage = image
        imagePreview.image = image
        
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (self.defaults.string(forKey: self.categoryKey) == "bathroom"){
            if (identifier == "fromGetToBathroom"){
                return true
            } else {
                return false
            }
            
            
        }
        
        
        
        
        // set lastSeenScreen to photos
        return true
    }
    
    
}
