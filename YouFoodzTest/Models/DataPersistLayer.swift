//
//  DataPersistLayer.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import Foundation

protocol DataPersistanceProtocol {
    func load()
    func save()
}

/* DataPersistLayer is an example of a Decorator pattern.  Essentially,
   rather add more responsibilities to the base class, or create a descendant
   class to provide the extra functionality, the Decorator implements the
   required extra functionality and calls through to the underlying object to
   provide the original functionality.
*/
class DataPersistLayer : DataPersistanceProtocol {
    func load() {
        // TODO: write loading code...
    }
    
    func save() {
        // TODO: write saving code...
    }
    
    var listBuilder : ListBuilderProtocol?
    var repositoryList = [RepositoryModel]()
    
    convenience init(_ builder : ListBuilderProtocol) {
        self.init()
        listBuilder = builder
        load()
    }
    
}

extension DataPersistLayer : CommsDelegate {
    func onSuccess(sender: Comms, results data: HTTPURLResponse) {
        (listBuilder as? CommsDelegate)?.onSuccess(sender: sender, results: data)
        if listBuilder != nil {
            repositoryList = listBuilder!.getRepositoryList()
        }
    }
    
    func onFailure(sender: Comms, details error: Error) {
        (listBuilder as? CommsDelegate)?.onFailure(sender: sender, details: error)
    }
}

extension DataPersistLayer : ListBuilderProtocol {
    func getRepositoryList() -> [RepositoryModel] {
        return repositoryList
    }
    
    func refresh(_ comms: Comms) {
        listBuilder?.refresh(comms)
    }
}
