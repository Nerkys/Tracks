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
    let resort: [Trip]
}

struct Trip {
    let title: String
    let statedAt: String
    let finishedAt: String
    //let resortImage: String
    
}

