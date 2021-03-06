//
//  TakePhotoViewController.swift
//  Catapult
//
//  Created by Alison Soong on 1/2/21.
//

import UIKit

class TakePhotoViewController: UIViewController {

    @IBOutlet weak var imageTake: UIImageView!
    @IBOutlet var takePictureButton: UIButton!
    @IBOutlet weak var UsePhotoStack: UIStackView!
    @IBOutlet weak var RetakePhotoStack: UIStackView!
    @IBOutlet weak var Background: UIView!
    @IBOutlet weak var InitialTakePhoto: UIView!
    
    let defaults = UserDefaults.standard
    let categoryKey = "photoCategory"
    let bathroomPhotosKey = "bathroomPhotoPaths"
    // etc, TODO: make the keys
    
    var curImage = UIImage()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        UsePhotoStack.isHidden = true
        RetakePhotoStack.isHidden = true
        Background.isHidden = true
        InitialTakePhoto.isHidden = false
        
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.delegate = self
            present(picker, animated: true)
        } else {
                fatalError("Camera is not available, please use real device.")
        }
        
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapButton(){
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.delegate = self
            present(picker, animated: true)
        } else {
                fatalError("Camera is not available, please use real device.")
        }
    }
    
    
    
    @IBAction func savePhoto(_ sender: AnyObject){
        let imageData = imageTake.image?.jpegData(compressionQuality: 1.0)
        let compressedImage = UIImage(data: imageData!)
//        let orientationFixedImage = compressedImage?.correctlyOrientedImage()
        let orientationFixedImage = compressedImage?.correctlyOrientedImage()
        
        UIImageWriteToSavedPhotosAlbum(orientationFixedImage!, nil, nil, nil)
                
        
        // add photo
        curImage = orientationFixedImage ?? UIImage()
        saveImageToDocumentDirectory(image: curImage)

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        
        // leave
        
        self.dismiss(animated: false, completion: nil)
        
        
        
    }
    
    // saves image to document directory
    func saveImageToDocumentDirectory(image: UIImage ) -> Bool {
        
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
        print("TEST 3: \(selectedImageTag)")
        arr.append(selectedImageTag)
        
        self.defaults.set(arr, forKey: self.bathroomPhotosKey)

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
    

}

extension TakePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        UsePhotoStack.isHidden = false
        RetakePhotoStack.isHidden = false
        Background.isHidden = false
        InitialTakePhoto.isHidden = true
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }

        
        imageTake.image = image
        
        
    }
    
    
}

extension UIImage {

    public func correctlyOrientedImage() -> UIImage {
        guard imageOrientation != .up else { return self }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return normalizedImage
    }

}



