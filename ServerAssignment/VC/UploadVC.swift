//
//  UploadVC.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 23/04/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import UIKit

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.takeImage(gesture:)))
        
        imageView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func takeImage(gesture: UIGestureRecognizer) {
        if(gesture.view as? UIImageView) != nil {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func upload(_ sender: Any) {
        let name = textField.text ?? "temp"
        let file = self.imageView.image
        
        let fileData = UserFile(name: name, location: nil, attachments: file)
        
        let service = UploadService()
        service.postImage(image: fileData) { result in
            print(result)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: ImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("cant take image")
        }
        
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
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
