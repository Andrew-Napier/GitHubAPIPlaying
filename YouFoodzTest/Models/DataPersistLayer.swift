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
    var listBuilder : ListBuilderProtocol?
    var repositoryList = [RepositoryModel]()

    convenience init(_ builder : ListBuilderProtocol) {
        self.init()
        listBuilder = builder
        load()
    }
    
    private func backgroundSave() {
        DispatchQueue.init(label: "workerThread").async {
            self.save()
        }
    }

    private func getStorageUrl() -> URL? {
        let path = FileManager.default.urls(for: .cachesDirectory,
                                 in: .userDomainMask).first
        let file = path?.appendingPathComponent("cache.dat", isDirectory: false)
        
        return file
    }
    
    func load() {
        guard let url = getStorageUrl() else {
            // if we can't retrieve cached data, it's not the end of the world!
            print("Storage URL was irretrievable (load)")
            return
        }
        
        if FileManager.default.fileExists(atPath: url.path) {
            guard let data = FileManager.default.contents(atPath: url.path) else {
                print("No data loaded from cache")
                return
            }
            let decoder = JSONDecoder()
            do {
                repositoryList = try decoder.decode([RepositoryModel].self, from: data)
            } catch {
                print("Decoding cached data failed")
                repositoryList = [RepositoryModel]()
            }
        }
    }
    
    func save() {
        guard let url = getStorageUrl() else {
            print("Storage URL was irretrievable (save)")
            return
        }
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(repositoryList)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path,
                                           contents: data,
                                           attributes: nil)
            
        } catch {
            // Again, we will ignore failures to cache retrievable data.
            // If we had some internal log mechanism, we could report the
            // failure there.  To emulate this, I'll use print...
            print(error.localizedDescription)
            return
        }
    }
}

extension DataPersistLayer : CommsDelegate {
    func onSuccess(sender: Comms, results data: HTTPURLResponse) {
        (listBuilder as? CommsDelegate)?.onSuccess(sender: sender, results: data)
        if listBuilder != nil {
            repositoryList = listBuilder!.getRepositoryList()
            backgroundSave()
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
