//
//  ImgModel.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 22/03/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import UIKit

class Image{
    //MARK: Properties
    var name: String
    var time: Double?
    var type: String?
    var location: String?
    var attachments: Data
    
    //MARK: Initializer
    init(time: Double?, type: String?, location: String?, attachments: UIImage){
        self.name = Image.generateFilename()
        self.time = time ?? 0
        self.type = type ?? "folder"
        self.location = location ?? ""
        self.attachments = Image.convertUIImageToData(attachments)
    }
    
    //MARK: Private methods
    static func convertUIImageToData(_ attachments: UIImage) -> Data{
        return attachments.pngData()!
    }
    
    static func generateFilename() -> String {
        let currentTime = String(Int(Date().timeIntervalSinceReferenceDate))
        return "temp_\(currentTime)"
    }
}
