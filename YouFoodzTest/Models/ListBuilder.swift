//
//  ListBuilder.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import UIKit

class ListBuilder: NSObject {
    static let dataUpdated = Notification.Name("dataUpdated")
    
    public var repositoryList = [RepositoryModelFacade]()
    
    public func Refresh(_ comms : Comms) {
        comms.makeRequest()
    }
    
    func createRepositoryList(from response : SearchRequestResponseModel) {
        repositoryList.removeAll()
        for item in response.items {
            repositoryList.append(RepositoryModelFacade(item))
        }
        repositoryList = repositoryList.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
        NotificationCenter.default.post(name: ListBuilder.dataUpdated, object: nil)
    }
}

extension ListBuilder : CommsDelegate {
    func onFailure(sender: Comms, details error: Error) {
        // TODO: Report failure so a UIAlertController dialogue can display error to user.
    }
    
    func onSuccess(sender: Comms, results data: HTTPURLResponse) {
        do {
            guard let receivedData = sender.commsData else {
                return
            }
            let response: SearchRequestResponseModel
            let decoder = JSONDecoder()
            do {
                response = try decoder.decode(SearchRequestResponseModel.self, from: receivedData)
                createRepositoryList(from: response)
            } catch let parsingError {
                print("Unable to read JSON data: \(parsingError)")
            }
        }
    }
}
