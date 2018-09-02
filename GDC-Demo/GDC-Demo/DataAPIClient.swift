//
//  APIClient.swift
//  GDC-Demo
//
//  Created by TaiHsinLee on 2018/8/31.
//  Copyright © 2018年 TaiHsinLee. All rights reserved.
//
import UIKit
import Foundation


enum dataApiUrl: String {
    case name = "https://stations-98a59.firebaseio.com/name.json"
    case address = "https://stations-98a59.firebaseio.com/address.json"
    case head = "https://stations-98a59.firebaseio.com/head.json"
}

class DataAPIClient {
    
    let semaphore = DispatchSemaphore(value: 1)
    
    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    
    typealias DataCompetionHandler = (String?, Error?) -> Void
    
    func getData(apiUrl: dataApiUrl, completionHandler completion: @escaping DataCompetionHandler) {
        
        
        guard let url =  URL(string: "\(apiUrl.rawValue)") else {
            completion(nil, DataError.invaliedUrl)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
                guard error == nil else {
                    completion(nil, DataError.requestFailed)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, DataError.requestFailed)
                    return
                }
            
                DispatchQueue.main.async {
                    guard let data = String(data: data!, encoding: .utf8 ) else { return }
                    completion(data, nil)
                }
        })
        dataTask.resume()
    }
}
