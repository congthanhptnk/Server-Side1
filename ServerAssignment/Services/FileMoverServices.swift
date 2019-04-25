//
//  FileMoverServices.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 24/04/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import Foundation

class FileMoverServices {
    private var apiUrl: String = StringRes.apiUrl + "/files"
    
    func moveFile(oldLoc: String, newLoc: String, original: String, complete: @escaping (Bool) -> Void) {
        guard let url = URL(string: (self.apiUrl + "/move")) else {
            fatalError("moveFile: failed url")
        }
        
        let param: [String: Any] = ["oldLoc": oldLoc,
                                    "newLoc": newLoc,
                                    "original": original]
        var body = NSMutableData()
        
        for(key, value) in param {
            if(key == "oldLoc"){
                body = NSMutableData(data: "oldLoc=\(value)".data(using: String.Encoding.utf8)!)
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
                DispatchQueue.main.async {
                    complete(true)
                }
            }
        }
        
        task.resume()
    }
}
