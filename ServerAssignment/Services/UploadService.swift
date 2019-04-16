//
//  WebServices.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 21/03/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import Foundation

class UploadService {
    private var apiUrl: String = StringRes.apiUrl
    
    //MARK: POST photo
    func postImage(image: Image){
        guard let url = URL(string: (apiUrl + "/upload")) else{
            fatalError("postImage: unable to init URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //Set body values
        let boundary = "Boundary-\(UUID().uuidString)"
        let param: [String:Any] = ["name": image.name,
                                   "time": image.time ?? 0,
                                   "type": image.type ?? 0,
                                   "location": image.location ?? ""]
    
        request.setValue("multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type")
        
        request.httpBody = createBody(parameters: param,
                                      boundary: boundary,
                                      data: image.attachments!,
                                      mimeType: "image/png",
                                      name: "file")
        //Create URL session
        let task = URLSession.shared.dataTask(with: request){data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response: \(response)")
            }
            
            guard let response = response as? HTTPURLResponse else {
                print ("Server: Server error")
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print(response.statusCode)
                return
            }
            
            if let data = data {
                print("YEEEEET" + String(data: data, encoding: .utf8)!)
            }
        }
        task.resume()
    }
    
    private func createBody(parameters: [String: Any],
                            boundary: String,
                            data: Data,
                            mimeType: String,
                            name: String) -> Data {
        let body = NSMutableData()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(name)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
}
extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
