//
//  ResortsDayCell.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 09.07.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class ResortsDayCell: UITableViewCell {
    
    @IBOutlet var view: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var maxSpeedLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var numberOfTracksLabel: UILabel!
    
    override func layoutSubviews() {
        view.layer.cornerRadius = 10.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.2
        view.clipsToBounds = false

        //layer.zPosition = 1
    }
}
