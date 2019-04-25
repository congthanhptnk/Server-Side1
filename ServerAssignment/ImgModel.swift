//
//  ImgModel.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 22/03/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import UIKit

class UserFile: Decodable{
    //MARK: Properties
    var name: String
    var time: Int
    var type: String?
    var location: String?
    var attachments: Data?
    var original: String?
    var _id: String?
    
    //MARK: Initializer
    //File init
    init(name: String, location: String?, attachments: UIImage?){
        self.time = Int((Date().timeIntervalSinceReferenceDate))
        self.name = UserFile.generateFilename(name: name, time: self.time)
        self.location = location ?? "./public"
        self.type = "jpg"
        
        if let attachments = attachments {
            self.attachments = UserFile.convertUIImageToData(attachments)
        }
    }
    
    //Folder init
    init(name: String, time: Int, location: String?) {
        self.name = name
        self.type = "folder"
        self.time = Int((Date().timeIntervalSinceReferenceDate))
        self.location = location ?? "./public"
    }
    
    //MARK: Private methods
    static func convertUIImageToData(_ attachments: UIImage) -> Data{
        return attachments.jpegData(compressionQuality: 0.2)!
    }
    
    static func generateFilename(name: String, time: Int) -> String {
        return "\(name)"
    }
}
