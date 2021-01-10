//
//  GetPhotoViewController.swift
//  Catapult
//
//  Created by Alison Soong on 1/2/21.
//

import UIKit

class GetPhotoViewController: UIViewController {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var initialButton: UIView!
    @IBOutlet weak var reselectButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        stack.isHidden = true
        background.isHidden = true
        reselectButton.isHidden = true
        initialButton.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
    }
    
    @IBAction func importImage(_sender: AnyObject){
        let image = UIImagePickerController()
        image.delegate = self

        image.sourceType = .photoLibrary

        image.allowsEditing = false
        reselectButton.isHidden = false
        initialButton.isHidden = true
        self.present(image, animated:true){
        }
        
    }
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            imagePreview.image = image
            
        }
        stack.isHidden = false
        background.isHidden = false
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
