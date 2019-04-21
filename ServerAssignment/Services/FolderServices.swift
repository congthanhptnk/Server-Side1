//
//  FolderServices.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 16/04/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import Foundation

class FolderServices {
    private var apiUrl: String = StringRes.apiUrl + "/folders"
    
    func createFolder(folder: Image) {
        guard let url = URL(string: (self.apiUrl)) else {
            fatalError("createFolder: failed url")
        }
        
        let param: [String:Any] = ["name": folder.name,
                                   "time": folder.time ?? 0,
                                   "type": folder.type ?? "folder",
                                   "location": folder.location!]
        //print(param)
        //let jsonData = try? JSONSerialization.data(withJSONObject: param)
        var body = NSMutableData()
        for(key, value) in param {
            if(key == "name") {
                body = NSMutableData(data: "name=\(value)".data(using: String.Encoding.utf8)!)
            } else {
                body.appendString("&\(key)=\(value)")
            }
        }
        
        var req = URLRequest(url: url)
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.httpMethod = "POST"
        req.httpBody = body as Data
        
        let task = URLSession.shared.dataTask(with: req) {data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
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
                //print(self.parseFilesJson(data)[0]._id)
                print(String(data: data, encoding: .utf8)!)
            }
        }
        
        task.resume()
    }
    
    func deleteFolder(folderPath: String) {
        guard let url = URL(string: (self.apiUrl)) else {
            fatalError("createFolder: failed url")
        }
        
        let postData = NSMutableData(data: "location=\(folderPath)".data(using: String.Encoding.utf8)!)
        
        var req = URLRequest(url: url)
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.httpMethod = "DELETE"
        req.httpBody = postData as Data
        
        let task = URLSession.shared.dataTask(with: req) {data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
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
                //print(self.parseFilesJson(data)[0]._id)
                print(String(data: data, encoding: .utf8)!)
            }
        }
        
        task.resume()
    }
}
