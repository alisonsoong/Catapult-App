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
    
    @IBAction func didTapButton(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
        InitialTakePhoto.isHidden = true
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
