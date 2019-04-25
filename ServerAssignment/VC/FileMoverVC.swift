//
//  FileMoverVC.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 24/04/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import UIKit

class FileMoverVC: UITableViewController {
    private var fileList: [UserFile] = []
    private let service = FilesGetServices()
    private var location: String = "./public"
    var oldFile: UserFile?
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(location == "./public") {
            self.navigationItem.title = "public"
            self.getFiles(location: "./public")
        } else {
            self.getFiles(location: location)
        }
        
        self.tableView.reloadData()
    }
    
    //MARK: Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.fileList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier2", for: indexPath)
        
        let text = self.fileList[indexPath.item].name
        
        cell.textLabel?.text = text
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = fileList[indexPath.item]
        if(file.type == "folder"){
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "FileMover") as! FileMoverVC
            
            controller.oldFile = self.oldFile
            controller.location = file.original!
            controller.navigationItem.title = file.name
            
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            print("aint a folder mate")
        }
    }
    
    //MARK: Private func
    private func getFiles(location: String){
        service.getFilesByFolder(folder: location) { (result) in
            self.fileList = result
            self.tableView.reloadData()
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        let service = FileMoverServices()
        
        service.moveFile(oldLoc: (self.oldFile?.location)!, newLoc: location, original: (self.oldFile?.original)!) { complete in
            if(complete) {
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    

}
