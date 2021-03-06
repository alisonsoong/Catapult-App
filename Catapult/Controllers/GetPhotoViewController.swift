//
//  GetPhotoViewController.swift
//  Catapult
//
//  Created by Alison Soong on 1/2/21.
//

import UIKit
import CoreData

class GetPhotoViewController: UIViewController, RefreshDataDelegate {
    
    func refreshData() {
        var viewDelegate: RefreshDataDelegate?
        viewDelegate!.refreshData()
    }
    
    
    

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var initialButton: UIView!
    @IBOutlet weak var reselectButton: UIButton!
    
    let defaults = UserDefaults.standard
    let categoryKey = "photoCategory"
    let bathroomPhotosKey = "bathroomPhotoPaths"
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
        
        saveImageToDocumentDirectory(image: curImage)
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        if let allItems = try? FileManager.default.contentsOfDirectory(atPath: documentDirectory) {
            print(allItems)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // saves image to document directory
    func saveImageToDocumentDirectory(image: UIImage ) {
        
        var arr = [String]()
        if (self.defaults.object(forKey: self.bathroomPhotosKey) == nil){
            arr = [String]()
            self.defaults.set([String](), forKey: self.bathroomPhotosKey)
        } else {
            arr = self.defaults.object(forKey: self.bathroomPhotosKey) as! [String]
        }
        print("TEST 2")
        let size = Int(arr.count)
        let newIndex = size + 1
        var selectedImageTag = ""
        if (self.defaults.string(forKey: self.categoryKey) == "bathroom"){
            selectedImageTag = "Bathroom"
        }
        selectedImageTag += String(newIndex)
        print("TEST 3")
        arr.append(selectedImageTag)
        self.defaults.set(arr, forKey: self.bathroomPhotosKey)
        
        print(arr)
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "\(selectedImageTag).png" // name of the image to be saved
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = image.jpegData(compressionQuality: 1.0),!FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try data.write(to: fileURL)
                print("file saved")

            } catch {
                print("error saving file:", error)
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }

}

extension GetPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }

        
        imagePreview.image = image
        
        
    }
    
    
}


protocol RefreshDataDelegate {
    func refreshData()
}

extension BathroomsViewController: RefreshDataDelegate {
    func refreshData() {
        photoTableView.reloadData()
    }
}
