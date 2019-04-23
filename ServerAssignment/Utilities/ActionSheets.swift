//
//  ActionSheets.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 24/04/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import UIKit

class ActionSheets {
    func displayActionSheet(vc: UIViewController) {
        let actionSheet = UIAlertController(title: "Options", message: "Choose an option", preferredStyle: .actionSheet)
        setup(actionSheet)
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    private func setup(_ actionSheet: UIAlertController){
        let copyOpt = UIAlertAction(title: "Copy", style: .default) { (alert: UIAlertAction!) in
            print("option")
        }
        
        let moveOpt = UIAlertAction(title: "Move", style: .default) { (alert: UIAlertAction) in
            print("move")
        }
        
        let deleteOpt = UIAlertAction(title: "Delete", style: .default) { (alert: UIAlertAction) in
            print("delete")
        }
        
        let cancelOpt = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(copyOpt)
        actionSheet.addAction(moveOpt)
        actionSheet.addAction(deleteOpt)
        actionSheet.addAction(cancelOpt)
    }
}
