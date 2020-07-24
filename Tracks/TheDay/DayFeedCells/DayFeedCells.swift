//
//  DayFeedCells.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 13.07.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

protocol DayFeedItemCell: UITableViewCell {
   // var lineTopConstraint: NSLayoutConstraint! { get set }
    var lineBottomConstraint: NSLayoutConstraint! { get set }
    //var viewTopConstraint: NSLayoutConstraint! { get set }
    //var viewBottomConstraint: NSLayoutConstraint! { get set }
}

protocol ExpandableFeedItemCell {
    var bottomView: UIView! { get set }
}

//class DayFeedRestCell: UITableViewCell, DayFeedItemCell {
//
//    @IBOutlet weak var lineTopConstraint: NSLayoutConstraint!
//    @IBOutlet weak var lineBottomConstraint: NSLayoutConstraint!
//    @IBOutlet weak var view: UIView!
//
//    override func layoutSubviews() {
//        view.layer.cornerRadius = 10.0
//        view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        view.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
//        view.layer.shadowRadius = 3
//        view.layer.shadowOpacity = 0.2
//        view.clipsToBounds = false
//    }
//}




class DayFeedEnterLeftResortCell: UITableViewCell, DayFeedItemCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resortNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    
    
    override func layoutSubviews() {
        view.layer.cornerRadius = 10.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.2
        //view.clipsToBounds = false
        view.layer.zPosition = 2
        
        shadowView.layer.cornerRadius = 10.0
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        shadowView.layer.shadowRadius = 3
        shadowView.layer.shadowOpacity = 0.2

        shadowView.layer.zPosition = 1
    }
}

class DayFeedTrackCell: UITableViewCell, DayFeedItemCell {
    
    @IBOutlet weak var lineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var difficultyImage: UIImageView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        view.layer.cornerRadius = 10.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.2
        //view.clipsToBounds = false
    }
}

class DayFeedFullRestCell: UITableViewCell, DayFeedItemCell, ExpandableFeedItemCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet public weak var bottomView: UIView! {
        didSet {
            bottomView.isHidden = true
        }
    }
    
    @IBOutlet weak var buttonTitleLabel: UIButton!
    
    var delegate: DayFeedCellDelegate?
    
    override func awakeFromNib() {
        view.layer.cornerRadius = 10.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.2
        view.clipsToBounds = false
        //view.layer.zPosition = 2
        
        buttonTitleLabel.addAction(for: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            
            self.delegate?.expandCell(cell: self)
        }
    }
}

class DayFeedLiftCell: UITableViewCell, DayFeedItemCell, ExpandableFeedItemCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet public weak var bottomView: UIView! {
        didSet {
            bottomView.isHidden = true
        }
    }

    @IBOutlet weak var buttonTitleLabel: UIButton!
    
    var delegate: DayFeedCellDelegate?
    
    override func awakeFromNib() {
        view.layer.cornerRadius = 10.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.2
        view.clipsToBounds = false
        
        
        
        buttonTitleLabel.addAction(for: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            
            self.delegate?.expandCell(cell: self)
        }
    }
}

protocol DayFeedCellDelegate {
    func expandCell(cell: UITableViewCell)
}
