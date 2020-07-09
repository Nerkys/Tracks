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
    let statistics: [Statistics]
//    let maxSpeed : Int
//    let distance: Int
//    let numberOfTracks: Int
}

struct Trip {
    let title: String
    let startedAt: String
    let finishedAt: String
    let image: String
    let numberOfActiveDays: Int
    let numberOfTracks: Int
    let distance: Int
    let flag: String
    let statistics: [Statistics]
    let resorts: [Resort]
    
}

struct Statistics {
    let title: String
    let image: String
    let value: Int
}

struct Resort {
    let title: String
    let days: [Day]
}

struct Day {
    let date: String
    let maxSpeed : Int
    let distance: Int
    let numberOfTracks: Int
}
