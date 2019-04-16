//
//  FilesDeleteServices.swift
//  ServerAssignment
//
//  Created by Tran Cong Thanh on 16/04/2019.
//  Copyright © 2019 Metropolia. All rights reserved.
//

import Foundation

class FilesDeleteServices {
    private var apiUrl: String = StringRes.apiUrl + "/files"
    
    func deleteAll() {
        guard let url = URL(string: (self.apiUrl)) else {
            fatalError("deleteAll: failed url")
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "DELETE"
        
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
                print(String(data: data, encoding: .utf8)!)
            }
        }
        
        task.resume()
    }
    
    func deleteSingle(id: String){
        guard let url = URL(string: (self.apiUrl + "/\(id)")) else {
            fatalError("deleteSingle: failed url")
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "DELETE"
        
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
                print(String(data: data, encoding: .utf8)!)
            }
        }
        
        task.resume()
    }
}
