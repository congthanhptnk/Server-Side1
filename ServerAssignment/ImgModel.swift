//
//  ImgModel.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 22/03/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import UIKit

class Image: Decodable{
    //MARK: Properties
    var name: String
    var time: Double?
    var type: String?
    var location: String?
    var attachments: Data?
    var original: String?
    var _id: String?
    
    //MARK: Initializer
    init(time: Double?, type: String?, location: String?, attachments: UIImage?){
        self.name = Image.generateFilename()
        self.time = time ?? 0
        self.type = type ?? "folder"
        self.location = location ?? ""
        if let attachments = attachments {
            self.attachments = Image.convertUIImageToData(attachments)
        }
    }
    
    init(name: String, time: Double?, location: String?, original: String?) {
        self.name = name
        self.time = time ?? 0
        self.type = "folder"
        self.location = location
        self.original = original
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
