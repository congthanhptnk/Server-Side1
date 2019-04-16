//
//  ViewController.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 21/03/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController!
    var image: Image?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tryGetAll()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func takeImage(_ sender: Any) {
//        imagePicker =  UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//
//        present(imagePicker, animated: true, completion: nil)
        
        tryGetSingle()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let takenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Unable to take pics")
        }
        
        imageView.image = takenImage
        image = Image(time: 1, type: "png", location: "./public/easy", attachments: takenImage)
        tryConnect()
    }
    
    private func tryConnect() {
        let webServices = UploadService()
        webServices.postImage(image: image!)
    }
    
    private func tryGetAll(){
        let fileGet = FilesGetServices()
        fileGet.getAllFiles()
    }
    
    private func tryGetSingle(){
        let fileGet = FilesGetServices()
        //fileGet.getSingleFile("5cb4b8fec0a369c56468c9d7")
        fileGet.test()
        //fileGet.getFilesByFolder(folder: "./public/easy")
    }

}

