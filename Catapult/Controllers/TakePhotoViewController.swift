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
    
    override func viewDidLoad(){
        super.viewDidLoad()
        UsePhotoStack.isHidden = true
        RetakePhotoStack.isHidden = true
        Background.isHidden = true
        InitialTakePhoto.isHidden = false
        
    }
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapButton(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
//        picker.allowsEditing = false
        present(picker, animated: true)
        InitialTakePhoto.isHidden = true
    }
    
    @IBAction func savePhoto(_ sender: AnyObject){
        let imageData = imageTake.image?.jpegData(compressionQuality: 1.0)
        let compressedImage = UIImage(data: imageData!)
//        let orientationFixedImage = compressedImage?.correctlyOrientedImage()
        let orientationFixedImage = compressedImage?.correctlyOrientedImage()
        
        UIImageWriteToSavedPhotosAlbum(orientationFixedImage!, nil, nil, nil)
                
        let alert = UIAlertController(title: "Saved", message: "Your image has been added and saved", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        // leave 
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
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
