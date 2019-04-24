//
//  ActionSheets.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 24/04/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import UIKit

class ActionSheets {
    private var file: UserFile?
    private var vc: UITableViewController?
    
    func displayActionSheet(vc: UITableViewController, file: UserFile) {
        self.file = file
        self.vc = vc
        
        let actionSheet = UIAlertController(title: "Options", message: "Choose an option", preferredStyle: .actionSheet)
        
        if(self.file?.type == "folder"){
            setupFolder(actionSheet)
        } else {
            setupFile(actionSheet)
        }
        
        self.vc!.present(actionSheet, animated: true, completion: nil)
    }
    
    private func setupFile(_ actionSheet: UIAlertController){
        let copyOpt = UIAlertAction(title: "Copy", style: .default) { (alert: UIAlertAction!) in
            print("option")
        }
        
        let moveOpt = UIAlertAction(title: "Move", style: .default) { (alert: UIAlertAction) in
            let controller = self.vc!.storyboard!.instantiateViewController(withIdentifier: "FileMover") as! FileMoverVC
            controller.oldFile = self.file
            let navVC = UINavigationController(rootViewController: controller)
            
            self.vc?.present(navVC, animated: true, completion: nil)
        }
        
        let deleteOpt = UIAlertAction(title: "Delete", style: .default) { (alert: UIAlertAction) in
            let delService = FilesDeleteServices()
            delService.deleteSingle(id: (self.file?._id)!)
        }
        
        let cancelOpt = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(copyOpt)
        actionSheet.addAction(moveOpt)
        actionSheet.addAction(deleteOpt)
        actionSheet.addAction(cancelOpt)
    }
    
    private func setupFolder(_ actionSheet: UIAlertController){
        let deleteOpt = UIAlertAction(title: "Delete", style: .default) { (alert: UIAlertAction) in
            let delService = FolderServices()
            delService.deleteFolder(folderPath: (self.file?.original)!)
        }
        
        let cancelOpt = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(deleteOpt)
        actionSheet.addAction(cancelOpt)
    }
}
