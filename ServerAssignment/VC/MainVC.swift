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
    private var location: String = ""
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.openOptions(gesture:)))
        self.tableView.addGestureRecognizer(longPressRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(location.isEmpty) {
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
    
    @objc func openOptions(gesture: UILongPressGestureRecognizer) {
        if(gesture.state == UIGestureRecognizer.State.began) {
            let touchPoint = gesture.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                print("wonderful: \(indexPath)")
                let actionSheets = ActionSheets()
                actionSheets.displayActionSheet(vc: self)
            }
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
