//
//  DateFormatter.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 06.08.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import Foundation

extension String {

    func toDate(withFormat format: String = "dd.MM.yyyy") -> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}

func dateForTripOnSeasonScreen(startedAt: String, finishedAt: String) -> String {
    
    if startedAt == finishedAt {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM"
        
        let result = dateFormatter.string(from: (startedAt.toDate())!)
        
        return result
    } else {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM"
        
        let startedDate = dateFormatter.string(from: (startedAt.toDate())!)
        let finishedDate = dateFormatter.string(from: (finishedAt.toDate())!)
        
        let result = "\(startedDate) - \(finishedDate)"
        return result
    }
}

func getNumberOfDaysForTripOnSeasonScreen(startedAt: String, finishedAt: String) -> Int {
    
    if startedAt == finishedAt {
        return 1
    } else {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let startedDate = dateFormatter.string(from: (startedAt.toDate())!)
        let finishedDate = dateFormatter.string(from: (finishedAt.toDate())!)
        let result = Int(finishedDate)! - Int(startedDate)!
        return result
    }
}

func dateForDay(date: String) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_RU")
    dateFormatter.dateFormat = "d MMMM"
    
    let result = dateFormatter.string(from: (date.toDate())!)
    return result
}
