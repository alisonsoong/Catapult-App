//
//  TestingEmailViewController.swift
//  Catapult
//
//  Created by Alison Soong on 2/12/21.
//

import UIKit
import SwiftSMTP

//let smtp = SMTP(
//    hostname: "smtp.gmail.com",     // SMTP server address
//    email: "asoongtesting@gmail.com",        // username to login
//    password: "a1s2d3f4%"            // password to login
//
//)




// purely for testing purposes!
class TestingEmailViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let testPhotoKey = "testPhotosArray"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
    }
    
//    @IBAction func pressedButton(_ sender: UIButton) {
//
//        let user = Mail.User(name: "Name", email: "asoongtesting@gmail.com")
//        let me = Mail.User(name: "Catapult Submissions", email: "asoongtesting@gmail.com")
//
//        let mail = Mail(
//            from: user,
//            to: [me],
//            subject: "Testing",
//            text: "Woah"
//        )
//
//        smtp.send(mail) { (error) in
//            if let error = error {
//                print(error)
//            }
//        }
//
//
//    }
    
    
    // display of image
    @IBOutlet weak var imageToSaveImageView: UIImageView! {
        didSet {
            imageToSaveImageView.image = UIImage(named: "image001")
        }
    }

    // display of saved image
    @IBOutlet weak var savedImageDisplayImageView: UIImageView!
    
    // display the image
    @IBAction func display(_ sender: UIButton) {
        display()
    }

    // displays image loaded from document directory
    func display() {
        savedImageDisplayImageView.image = loadImageFromDocumentDirectory(nameOfImage: "image001.png")
    }


    // saves image to document directory
    func saveImageToDocumentDirectory(image: UIImage ) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "image001.png" // name of the image to be saved
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
    
    
    // image picker controller start ---- get photo from photos album -----
    @IBAction func importImage(_sender: AnyObject){
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        self.present(image, animated:true){
            
        }
        
        
    }
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            imageToSaveImageView.image = image
        }

    }
    // ----- end -----
    
    
    @IBAction func reset(_ sender: UIButton) {
        // check what is in the directory before deleting
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        if let allItems = try? FileManager.default.contentsOfDirectory(atPath: documentDirectory) {
            print(allItems)
        }
        removeImage(itemName:"image001", fileExtension: "png")
        savedImageDisplayImageView.image = nil
        // check what is in the directory after deleting
        let documentDirectory2 = paths[0]
        if let allItems = try? FileManager.default.contentsOfDirectory(atPath: documentDirectory2) {
            print(allItems)
        }
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

extension TestingEmailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }

        // save image when selected
        imageToSaveImageView.image = image
        saveImageToDocumentDirectory(image: image)
        print("done")
        
    }
    
    
}
