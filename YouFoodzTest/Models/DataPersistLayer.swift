//
//  DataPersistLayer.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import Foundation

/* DataPersistLayer is an example of a Decorator pattern.  Essentially,
   rather add more responsibilities to the base class, or create a descendant
   class to provide the extra functionality, the Decorator implements the
   required extra functionality and calls through to the underlying object to
   provide the original functionality.
*/
class DataPersistLayer {
    var listBuilder : ListBuilderProtocol?
    
    convenience init(_ builder : ListBuilderProtocol) {
        self.init()
        listBuilder = builder
    }
    
}

extension DataPersistLayer : CommsDelegate {
    func onSuccess(sender: Comms, results data: HTTPURLResponse) {
        (listBuilder as? CommsDelegate)?.onSuccess(sender: sender, results: data)
    }
    
    func onFailure(sender: Comms, details error: Error) {
        (listBuilder as? CommsDelegate)?.onFailure(sender: sender, details: error)
    }
}

extension DataPersistLayer : ListBuilderProtocol {
    func getRepositoryList() -> [RepositoryModel] {
        return listBuilder?.getRepositoryList() ?? []
    }
    
    func refresh(_ comms: Comms) {
        listBuilder?.refresh(comms)
    }
}
