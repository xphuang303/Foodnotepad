//
//  DetailViewController.swift
//  foodnotepad1
//
//  Created by iOS on 2019/10/26.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var storeField: UITextField!
    
    @IBOutlet weak var foodphoto: UIImageView!
    var foodItem:FoodItem?
    var imageData:ImageData?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = foodItem?.name
        configuenameField()
        configuenumberField()
        configuestoreField()
        if imageData?.data1 != nil{
            foodphoto.image = UIImage(data: imageData!.data1!)
        }
        else if imageData?.data2 != nil{
            foodphoto.image = UIImage(data: imageData!.data2!)
        }
        else {
            foodphoto.image = UIImage(named: "Nophoto")
        }
        
    }
    
    @IBAction func photoAction(_ sender: UIButton){
        let vc = UIImagePickerController()
        if sender.tag == 1{
            vc.sourceType = .camera
            vc.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.camera)!
        }
        else if sender.tag == 2 {
            vc.sourceType = .photoLibrary
        }
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if picker.sourceType == .camera {
            guard let image = info[.editedImage] as? UIImage else {
                print("No image found")
                return
            }
            foodphoto.image = image
            
            // Save the image to Photo library
            UIImageWriteToSavedPhotosAlbum(image, nil, nil , nil)
            picker.dismiss(animated: true)
        }
        else if picker.sourceType == .photoLibrary {
            if let possibleImage = info[.editedImage] as? UIImage {
                foodphoto.image = possibleImage
            } else if let possibleImage = info[.originalImage] as? UIImage {
                foodphoto.image = possibleImage
            } else {
                return
            }
            dismiss(animated: true)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configuenameField() {
        if foodItem?.name != nil{
            nameField.text = foodItem?.name
        }
        nameField.autocorrectionType = .yes
        nameField.returnKeyType = .done
        nameField.clearButtonMode = .never
    }
    func configuenumberField() {
        if foodItem?.number != nil{
            numberField.text = foodItem?.number
        }
        numberField.autocorrectionType = .yes
        numberField.returnKeyType = .done
        numberField.clearButtonMode = .never
    }
    func configuestoreField() {
        if foodItem?.store != nil{
            storeField.text = foodItem?.store
        }
        storeField.autocorrectionType = .yes
        storeField.returnKeyType = .done
        storeField.clearButtonMode = .never
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
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
