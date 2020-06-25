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
    //let averageSpeed : Int
}

struct Trip {
    let title: String
    let startedAt: String
    let finishedAt: String
    let image: String
    
}

