//
//  FilesGetServices.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 16/04/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import Foundation

class FilesGetServices {
    private var apiUrl: String = StringRes.apiUrl + "/files"
    
    func getAllFiles(result: @escaping ([Image]) -> Void) {
        guard let url = URL(string: (self.apiUrl)) else {
            fatalError("getAllFiles: failed url")
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        
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
                print(self.parseFilesJson(data)[0]._id)
                DispatchQueue.main.async {
                    result(self.parseFilesJson(data))
                }
                //print(String(data: data, encoding: .utf8)!)
            }
        }
        
        task.resume()
    }
    
    func getSingleFile(_ id: String) {
        guard let url = URL(string: (self.apiUrl + "/fileId/\(id)")) else {
            fatalError("getSingleFile: failed url")
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        
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
                print(self.parseSingleFile(data))
                print(String(data: data, encoding: .utf8)!)
            }
        }
        
        task.resume()
    }
    
    func getFilesByFolder(folder: String, completion: @escaping ([Image]) -> Void) {
        guard let url = URL(string: (self.apiUrl + "/folder")) else {
            fatalError("getSingleFile: failed url")
        }
        
        let postData = NSMutableData(data: "location=\(folder)".data(using: String.Encoding.utf8)!)
        
        var req = URLRequest(url: url)
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.httpMethod = "POST"
        req.httpBody = postData as Data
        //req.addValue("application/json", forHTTPHeaderField: "Accept")
        
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
                DispatchQueue.main.async {
                    completion(self.parseFilesJson(data))
                }
            }
        }
        
        task.resume()
    }
    
    private func parseFilesJson(_ data: Data) -> [Image] {
        guard let allFiles = try? JSONDecoder().decode([Image].self, from: data) else {
            fatalError("Parse json failed")
        }
        
        return allFiles
    }
    
    private func parseSingleFile(_ data: Data) -> Image {
        guard let file = try? JSONDecoder().decode(Image.self, from: data) else {
            fatalError("Parse json failed")
        }
        
        return file
    }
}
