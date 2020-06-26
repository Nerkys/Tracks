//
//  Models.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 23.06.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

struct Season {
    let title: String
    let trip: [Trip]
    let maxSpeed : Int
    let distance: Int
    let numberOfTracks: Int
}

struct Trip {
    let title: String
    let startedAt: String
    let finishedAt: String
    let image: String
    
}

