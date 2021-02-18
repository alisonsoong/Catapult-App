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
    let bathroomFolderKey = "bathroomFolder"
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
        
        if (self.defaults.string(forKey: self.categoryKey) == "bathroom"){
            
            
            var arr: [URL] = []
            arr = self.defaults.object(forKey: self.bathroomPhotosKey) as? [URL] ?? []
            
            
            let size = Int(arr.count)
            let newIndex = size + 1
            var selectedImageTag = "Bathroom"
            selectedImageTag += String(newIndex)
            
   
            for val in arr {
                print("---\(val)")
            }
            print("SELECTED IMAGE TAG \(selectedImageTag)")
            
            // get access to shared instance of the file manager
            let fileManager = FileManager.default
            
            // Get the URL for the users home directory
            let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // Get the document URL as a string
            let documentPath = documentsURL.path
            
            // Create filePath URL by appending final path component (name of image)
            let filePath = documentsURL.appendingPathComponent("\(String(selectedImageTag)).png")
            
            do {
                let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                
                for file in files {
                    if "\(documentPath)/\(file)" == filePath.path {
                        try fileManager.removeItem(atPath: filePath.path)
                    }
                }
            } catch {
                print("Could not add image from document directory: \(error)")
            }
            
            
            print("FILE PATH \(filePath)")
            do {
                
                if let pngImageData = curImage.pngData(){
                    print("YES")
                    try pngImageData.write(to: filePath, options: .atomic)
                    arr.append(filePath)
                    
                    self.defaults.set(arr, forKey: self.bathroomPhotosKey)
                }
            } catch {
                print("Couldn't write image")
            }
            
            print("NUMBER OF ITEMS \(arr.count)")
            
        }
        
        
        
        self.dismiss(animated: true, completion: nil)
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
