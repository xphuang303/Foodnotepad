//
//  DetailViewController.swift
//  foodnotepad
//
//  Created by iOS on 2019/10/3.
//  Copyright © 2019 Xphuang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var name:String?
    var number:String?
    var store:String?
    @IBOutlet weak var foodphoto: UIImageView!
    
    
    @IBAction func camera(_ sender: UIButton) {
        let vc = UIImagePickerController()
        if sender.tag == 1 {
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
    @IBAction func getText(_ sender: UITextField) {
        switch sender.tag {
        case 0:
            name = sender.text
        case 1:
            number = sender.text
        case 2:
            store = sender.text
        default:
            break
        }
    }
    
    /*
    func textFieldShouldReturn(textField:UITextField) ->Bool{
        收起键盘
        textField.resignFirstResponder()
        return true;
    }
    */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if picker.sourceType == .camera {
            guard let image = info[.editedImage] as? UIImage else {
                print("No image found")
                return
            }
            //print(image.size)// print out the image size as a test
            foodphoto.image = image
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
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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
