//
//  TheTripCell.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 07.07.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class TheTripCell: UITableViewCell {
    
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var tripImage: UIImageView!
    
    let coverLayer = CALayer()
    
    override func layoutSubviews() {
        
        
        coverLayer.frame = tripImage.bounds
        coverLayer.backgroundColor = UIColor.black.cgColor
        coverLayer.opacity = 0.25
        tripImage.layer.addSublayer(coverLayer)
        
    }
}
