//
//  ListBuilderProtocol.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import Foundation

protocol ListBuilderProtocol {
    /// Returns an array of repositories
    func getRepositoryList() -> [RepositoryModel]
    /// Triggers another refresh using the provided comms object.
    /// The comms object is provided as a means of performing Dependency injection.
    func refresh(_ comms : Comms)
}

