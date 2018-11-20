//
//  RepositoryModel.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import Foundation

struct SearchRequestResponseModel : Codable {
    enum CodingKeys : String, CodingKey {
        case count = "total_count"
        case isIncomplete = "incomplete_results"
        case items = "items"
    }
    
    let count : Int
    let isIncomplete : Bool
    let items : [RepositoryModel]
}


struct RepositoryModel : Codable {
    enum CodingKeys : String, CodingKey {
        case name = "full_name"
        case isFork = "fork"
        case stargazers = "stargazers_count"
        case creationTimeString = "created_at"
        case repoUrl = "html_url"
    }
    
    let name : String
    let isFork : Bool
    let stargazers : Int
    let creationTimeString : String
    let repoUrl : String
    
}
