//
//  ListBuilderProtocol.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import Foundation

protocol ListBuilderProtocol {
    func getRepositoryList() -> [RepositoryModelFacade]
    func refresh(_ comms : Comms)
}

