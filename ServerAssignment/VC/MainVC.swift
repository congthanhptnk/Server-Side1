//
//  MainVC.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 22/04/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    //MARK: Properties
    private var fileList: [UserFile] = []
    private let service = FilesGetServices()
    private var location: String = "./public"
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.openOptions(gesture:)))
        self.tableView.addGestureRecognizer(longPressRecognizer)
        
        if(location == "./public"){
            self.navigationItem.title = "Home"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getFiles(location: location)
    }
    
    //MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fileList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        
        let text = self.fileList[indexPath.item].name
        
        cell.textLabel?.text = text
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = fileList[indexPath.item]
        if(file.type == "folder"){
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "MyTable") as! MainVC
            
            controller.location = file.original!
            controller.navigationItem.title = file.name
            
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            self.onFileClick(file: file)
            
        }
    }
    
    //MARK: Private func
    private func getFiles(location: String){
        service.getFilesByFolder(folder: location) { (result) in
            self.fileList = result
            self.tableView.reloadData()
        }
    }
    
    @IBAction func postOptions(_ sender: Any) {
        displayPostOptions()
    }
    
    private func displayPostOptions(){
        let alert = UIAlertController(title: "Options", message: "", preferredStyle: .alert)
        
        let uploadFile = UIAlertAction(title: "Upload file", style: .default) { (alert) in
            self.performSegue(withIdentifier: "uploadSegue", sender: nil)
        }
        let createFolder = UIAlertAction(title: "New folder", style: .default) { (alert) in
            self.performSegue(withIdentifier: "createFolderSegue", sender: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(uploadFile)
        alert.addAction(createFolder)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func openOptions(gesture: UILongPressGestureRecognizer) {
        if(gesture.state == UIGestureRecognizer.State.began) {
            let touchPoint = gesture.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let curFile = fileList[indexPath.row]
                
                let actionSheets = ActionSheets()
                actionSheets.displayActionSheet(vc: self, file: curFile)
            }
        }
    }
    
    private func onFileClick(file: UserFile) {
        let alert = UIAlertController(title: "File Clicked", message: "You've clicked: \(file.name) at \(file.location!)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "uploadSegue" {
            guard let nav = segue.destination as? UINavigationController else {
                fatalError("Destination not navcontroller")
            }
            guard let vc = nav.topViewController as? UploadVC else {
                fatalError("TopView not Upload")
            }
            
            vc.location = self.location
        } else if (segue.identifier == "createFolderSegue") {
            guard let folderVC = segue.destination as? NewFolderVC else {
                fatalError("This is not newFolderVC")
            }
            
            folderVC.location = self.location
        }
    }
    

}
