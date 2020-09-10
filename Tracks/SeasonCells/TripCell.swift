//
//  TripCell.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 24.06.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class TripCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var tripImage: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet var numberOfActiveDaysLabel: UILabel!
    @IBOutlet var numberOfTracksLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    
    
    let coverLayer = CALayer()
    
    override func layoutSubviews() {
        view.layer.cornerRadius = 10.0
//        view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        view.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
//        view.layer.shadowRadius = 3
//        view.layer.shadowOpacity = 0.2
        view.layer.masksToBounds = true
        view.layer.zPosition = 2

        
        shadowView.layer.cornerRadius = 10.0
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        shadowView.layer.shadowRadius = 3
        shadowView.layer.shadowOpacity = 0.2
        
        shadowView.layer.zPosition = 1
        
        coverLayer.frame = tripImage.bounds
        coverLayer.backgroundColor = UIColor.black.cgColor
        coverLayer.opacity = 0.15
        tripImage.layer.addSublayer(coverLayer)
        
    }


    
    

}


