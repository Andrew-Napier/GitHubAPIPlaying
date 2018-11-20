//
//  Comms.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import Foundation

class Comms: NSObject {
    var delegate : CommsDelegate?
    var commsData : Data?
    
    func makeRequest() {
    
        let headers = ["Cache-Control": "no-cache"]
        
        let request = NSMutableURLRequest(url:
            NSURL(string: "https://api.github.com/search/repositories?q=name:Shopify&order=asc")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest,
                                        completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                self.delegate?.onFailure(sender: self, details: error!)
            } else {
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("The response should be defined, when no error occurred")
                    // Possibly should throw a custom Error type rather than
                    // silently return.  Ommited for now...
                    return
                }
                self.commsData = data
                self.delegate?.onSuccess(sender: self, results: httpResponse)
            }
        })
        
        dataTask.resume()
    }
}
