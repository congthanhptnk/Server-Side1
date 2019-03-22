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
    var lat: Double?
    var lon: Double?
    var description: String?
    var attachments: Data
    
    //MARK: Initializer
    init(lat: Double?, lon: Double?, description: String?, attachments: UIImage){
        self.name = Image.generateFilename()
        self.lat = lat ?? 0
        self.lon = lon ?? 0
        self.description = description ?? ""
        self.attachments = Image.convertUIImageToData(attachments)
    }
    
    //MARK: Private methods
    static func convertUIImageToData(_ attachments: UIImage) -> Data{
        return attachments.pngData()!
    }
    
    static func generateFilename() -> String {
        let currentTime = String(Int(Date().timeIntervalSinceReferenceDate))
        return "temp_\(currentTime).png"
    }
}
