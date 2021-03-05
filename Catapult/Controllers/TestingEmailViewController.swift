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
    
    
    @IBOutlet weak var imageToSaveImageView: UIImageView! {
        didSet {
            imageToSaveImageView.image = UIImage(named: "buildingImage")
        }
    }
    @IBAction func save(_ sender: UIButton) {
        save()
    }

    @IBOutlet weak var savedImageDisplayImageView: UIImageView!
    
    @IBAction func display(_ sender: UIButton) {
        display()
    }

    @objc func save() {
//        if let buildingImage = UIImage(named: "buildingImage") {
//            DispatchQueue.global(qos: .background).async {
//                StorageType.store(image: buildingImage,
//                            forKey: "buildingImage",
//                            withStorageType: .fileSystem)
//            }
//        }
        
        
    }

    @objc func display() {
//        DispatchQueue.global(qos: .background).async {
//            if let savedImage = StorageType.retrieveImage(forKey: "buildingImage",
//                                                    inStorageType: .fileSystem) {
//                DispatchQueue.main.async {
//                    self.savedImageDisplayImageView.image = savedImage
//                }
//            }
//        }
        
//        savedImageDisplayImageView.image = loadImageFromDiskWith(fileName: "testing")
        savedImageDisplayImageView.image = loadImageFromDocumentDirectory(nameOfImage: "image001.png")
    }
    
    func saveImage(imageName: String, image: UIImage) {

        
         guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

            let fileName = imageName
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            guard let data = image.jpegData(compressionQuality: 1) else { return }

            //Checks if file exists, removes it if so.
            if FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    try FileManager.default.removeItem(atPath: fileURL.path)
                    print("Removed old image")
                } catch let removeError {
                    print("couldn't remove file at path", removeError)
                }

            }

            do {
                try data.write(to: fileURL)
            } catch let error {
                print("error saving file with error", error)
            }

    }



    func saveImageToDocumentDirectory(image: UIImage ) {
        print("TEST")
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("TEST")
        let fileName = "image001.png" // name of the image to be saved
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        print("TEST")
        if let data = image.jpegData(compressionQuality: 1.0),!FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
    }


    func loadImageFromDocumentDirectory(nameOfImage : String) -> UIImage {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first{
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(nameOfImage)
            let image    = UIImage(contentsOfFile: imageURL.path)
            print(imageURL.path)
            return image!
        }
        return UIImage.init(named: "image001.png")!
    }
    
    func loadImageFromDiskWith(fileName: String) -> UIImage? {

          let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

            let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
            let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

            if let dirPath = paths.first {
                let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
                let image = UIImage(contentsOfFile: imageUrl.path)
                return image

            }

            return nil
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
    }
    
    @IBAction func importImage(_sender: AnyObject){
        print("HELLO")
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        self.present(image, animated:true){
            
        }
        
        
    }
  
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        print("doneeee")
        if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            imageToSaveImageView.image = image
            
//            saveImage(imageName: "testing", image: UIImage)
        }
        

    }
    
    
    @IBAction func reset(_ sender: UIButton) {
        removeImage(itemName:"image001", fileExtension: "png")
    }
    
    
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

extension TestingEmailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }

        
        imageToSaveImageView.image = image
        saveImageToDocumentDirectory(image: image)
        print("done")
        
    }
    
    
}
