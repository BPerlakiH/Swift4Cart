//
//  FXDownloader.swift
//  SwiftCart
//
//  Created by Balazs Perlaki-Horvath on 10/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import UIKit 

class FXDownloader {

    func downloadRates(apiKey: String, currencies: [String], completion: @escaping (_ results: Data?, _ error : NSError?) -> Void) {
        let urlString = "http://apilayer.net/api/live?access_key=\(apiKey)&currencies=" + currencies.joined(separator: ",")
        guard let url:URL = URL(string: urlString) else {
            completion(nil, _createError(message: "Invalid parameters sent to API"))
            return
        }
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                OperationQueue.main.addOperation({
                    completion(nil, self._createError(message: "Unknown API response: " + error.debugDescription))
                })
                return
            }
            guard let _ = response as? HTTPURLResponse, let data = data else {
                OperationQueue.main.addOperation({
                    completion(nil, self._createError(message: "Unknown API response"))
                })
                return
            }
            OperationQueue.main.addOperation({
                completion(data, nil)
            })
        }
        dataTask.resume()
    }

    func _createError(message: String) -> NSError {
        return NSError(domain: "apiLayer", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:message])
    }

}


