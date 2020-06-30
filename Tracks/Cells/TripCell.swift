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
    
    override func layoutSubviews() {
        view.layer.cornerRadius = 10.0
//        view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        view.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
//        view.layer.shadowRadius = 3
//        view.layer.shadowOpacity = 0.2
       // view.clipsToBounds = true
        view.layer.masksToBounds = true

        //layer.zPosition = 1
        
        shadowView.layer.cornerRadius = 10.0
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        shadowView.layer.shadowRadius = 3
        shadowView.layer.shadowOpacity = 0.2
        
        shadowView.layer.zPosition = -1
        
    }
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    

}

extension TripCell {
    
}
