//
//  CommsDelegate.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import UIKit

protocol CommsDelegate {
    func onSuccess(sender : Comms, results data : HTTPURLResponse)
    func onFailure(sender : Comms, details error : Error)
}
