//
//  RepositoryModelFacade.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import Foundation

class RepositoryModelFacade {
    var name : String = ""
    var isFork : Bool = false
    var stargazers : Int = 0
    var creationTime : Date?
    var repoUrl : String = ""
    var dateFormatter = ISO8601DateFormatter()

    convenience init(_ model : RepositoryModel) {
        self.init()
        self.name = model.name
        self.isFork = model.isFork
        self.repoUrl = model.repoUrl
        self.stargazers = model.stargazers
        self.creationTime = dateFormatter.date(from: model.creationTimeString)
    }
    
    func getAge() -> String {
        guard let beginningTime = self.creationTime else {
            return "Unknown"
        }
        
        let endTime = Date()
        let duration = DateInterval(start: beginningTime, end: endTime)
        
        return convertDurationToString(duration.duration)
    }
    
    func convertDurationToString(_ interval : TimeInterval) -> String {
        let days = Int((interval / 86400.0).rounded(.towardZero))
        let seconds = Int(interval.truncatingRemainder(dividingBy: 60.0).rounded(.towardZero))
        let minutes = Int(interval.truncatingRemainder(dividingBy: 3600.0)/60.0)
        let hours = Int(interval.truncatingRemainder(dividingBy: 86400.0)/3600.0)
        
        return "\(days) days \(hours) hours \(minutes) minutes \(seconds) seconds"
    }
}
