//
//  MasterController.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import UIKit

class MasterController: NSObject {
    let comms = Comms()
    let listBuilder = ListBuilder()
    
    var repositoryCount : Int {
        get {
            return listBuilder.repositoryList.count
        }
    }
    
    private func getRepoList() {
        comms.delegate = listBuilder
        comms.makeRequest()
    }
    
    func initialise() {
        getRepoList()
        
    }
    
    private func setupListView() {
        guard let masterViewController = UIApplication.shared.delegate?.window??.rootViewController else {
            return
        }
        
        masterViewController
    }
}
