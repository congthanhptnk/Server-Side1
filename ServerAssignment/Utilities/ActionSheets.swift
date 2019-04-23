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
    
    func displayActionSheet(vc: UIViewController, file: UserFile) {
        self.file = file
        
        let actionSheet = UIAlertController(title: "Options", message: "Choose an option", preferredStyle: .actionSheet)
        
        if(self.file?.type == "folder"){
            setupFolder(actionSheet)
        } else {
            setupFile(actionSheet)
        }
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    private func setupFile(_ actionSheet: UIAlertController){
        let copyOpt = UIAlertAction(title: "Copy", style: .default) { (alert: UIAlertAction!) in
            print("option")
        }
        
        let moveOpt = UIAlertAction(title: "Move", style: .default) { (alert: UIAlertAction) in
            print("move")
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
