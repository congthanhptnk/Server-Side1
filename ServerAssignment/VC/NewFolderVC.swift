//
//  NewFolderVC.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 25/04/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import UIKit

class NewFolderVC: UIViewController {
    var location: String!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        let service = FolderServices()
        service.createFolder(name: textField.text ?? "folder1", location: self.location) { complete in
            if(complete) {
                self.navigationController?.popViewController(animated: true)
            }
        }
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
