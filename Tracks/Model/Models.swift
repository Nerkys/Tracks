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
}

struct Trip {
    let title: String
    let startedAt: String
    let finishedAt: String
    let image: [String]
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
    let statistics: [Statistics]
    let feedItems: [DayFeedItem]
    let coordinates: Coordinates
    
    struct Coordinates {
        let latitude: Double
        let longitude: Double
    }
}



struct DayFeedItem: Equatable {
    static func == (lhs: DayFeedItem, rhs: DayFeedItem) -> Bool {
        if lhs.type == rhs.type { return true } else { return false }
    }
    
    let title: String
    let type: ItemType

    enum ItemType: Equatable {
        case rest, lift(liftName: String), enterLeftResort(title: String, resortName: String), track(difficultyImageName: String)
    }
}

struct UIDayFeedItem {
    let title: String
    let type: DayFeedItem.ItemType
    var isExpanded: Bool
    
}

struct UIMapSummaryStatisticsItem {
    let title: String
    let type: ItemType
    
    enum ItemType {
        case rest, lift(liftName: String), track(difficultyImageName: String)
    }
    
}
