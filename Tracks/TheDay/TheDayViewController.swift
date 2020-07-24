//
//  TheDayViewController.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 10.07.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class TheDayViewController: UIViewController {
    
    @IBOutlet var theDayTableView: UITableView!
    
    var day: Day!
    var feedItems: [UIDayFeedItem] = []
    var alpha = 0
    

    //weak var delegate: TheDayViewController?
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setDay(day: Day) {
        self.day = day
        feedItems = day.feedItems.map {
            UIDayFeedItem(title: $0.title, type: $0.type, isExpanded: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theDayTableView.delegate = self
        theDayTableView.dataSource = self
        theDayTableView.tableFooterView = UIView(frame: .zero)
        theDayTableView.rowHeight = UITableView.automaticDimension
        theDayTableView.estimatedRowHeight = 90
        
        theDayTableView.separatorStyle = .none
            
        self.hideNavigationBar()
        
        let dayFeedFullRestCellNib = UINib(nibName: String(describing: DayFeedFullRestCell.self), bundle: nil)
        theDayTableView.register(dayFeedFullRestCellNib, forCellReuseIdentifier: String(describing: DayFeedFullRestCell.self))
        let dayFeedLiftCellNib = UINib(nibName: String(describing: DayFeedLiftCell.self), bundle: nil)
        theDayTableView.register(dayFeedLiftCellNib, forCellReuseIdentifier: String(describing: DayFeedLiftCell.self))
        let dayFeedEnterLeftResortCellNib = UINib(nibName: String(describing: DayFeedEnterLeftResortCell.self), bundle: nil)
        theDayTableView.register(dayFeedEnterLeftResortCellNib, forCellReuseIdentifier: String(describing: DayFeedEnterLeftResortCell.self))
        let dayFeedTrackCellNib = UINib(nibName: String(describing: DayFeedTrackCell.self), bundle: nil)
        theDayTableView.register(dayFeedTrackCellNib, forCellReuseIdentifier: String(describing: DayFeedTrackCell.self))
        
        
        
    }
    //var selectedIndex: IndexPath = IndexPath(row: 2, section: 0)
}

extension TheDayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return day.feedItems.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = theDayTableView.dequeueReusableCell(withIdentifier: "TheDayStatisticsCell", for: indexPath) as! TheDayStatisticsCell
            
            cell.configure(with: day)
            cell.selectionStyle = .none
            
            return cell
            
            
        } else {
            var cell: DayFeedItemCell!
            let item = feedItems[indexPath.row - 1]
            
            switch item.type {
            case .rest:
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedFullRestCell.self), for: indexPath) as? DayFeedItemCell
                //(cell as? DayFeedFullRestCell)?.lineBottomConstraint.constant = indexPath.row == feedItems.count ? 60 : -20
                (cell as? DayFeedFullRestCell)?.bottomView.isHidden = !item.isExpanded
                (cell as? DayFeedFullRestCell)?.lineTopConstraint.constant = indexPath.row == 1 ? -6 : -20
                (cell as? DayFeedFullRestCell)?.delegate = self
                

            case .lift(let liftName):
                cell = ((tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedLiftCell.self), for: indexPath) as? DayFeedLiftCell)!)
                (cell as? DayFeedLiftCell)?.titleLabel.text = "Подъемник \(liftName)"
                //(cell as? DayFeedLiftCell)?.lineBottomConstraint.constant = indexPath.row == feedItems.count ? 60 : -20
                (cell as? DayFeedLiftCell)?.bottomView.isHidden = !item.isExpanded
                (cell as? DayFeedLiftCell)?.lineTopConstraint.constant = indexPath.row == 1 ? -6 : -20
                (cell as? DayFeedLiftCell)?.delegate = self

            case .enterLeftResort(let title, let resortName):
                cell = (tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedEnterLeftResortCell.self), for: indexPath) as? DayFeedItemCell)!
                (cell as? DayFeedEnterLeftResortCell)?.titleLabel.text = title
                (cell as? DayFeedEnterLeftResortCell)?.resortNameLabel.text = resortName
                (cell as? DayFeedEnterLeftResortCell)?.lineBottomConstraint.constant = indexPath.row == feedItems.count ? 30 : -20
                (cell as? DayFeedEnterLeftResortCell)?.lineTopConstraint.constant = indexPath.row == 1 ? -6 : -20

            case .track(let difficultyImageName):
                cell = (tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedTrackCell.self), for: indexPath) as? DayFeedItemCell)!
                (cell as? DayFeedTrackCell)?.difficultyImage.image = UIImage(named: difficultyImageName)
                //(cell as? DayFeedTrackCell)?.lineBottomConstraint.constant = indexPath.row == feedItems.count ? 60 : -20
                (cell as? DayFeedTrackCell)?.lineTopConstraint.constant = indexPath.row == 1 ? -6 : -20
            }
            
            return cell
            
        }
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if let cell = tableView.cellForRow(at: indexPath) as? ExpandableFeedItemCell {
//            
//            feedItems[indexPath.row - 1].isExpanded.toggle()
//            
//            UIView.animate(withDuration: 0.3) {
//                cell.bottomView.isHidden.toggle()
//            }
//
//            tableView.beginUpdates()
//            tableView.endUpdates()
//
//        }
//    }

}

extension TheDayViewController: DayFeedCellDelegate {
    func expandCell(cell: UITableViewCell) {
        guard let indexPath = theDayTableView.indexPath(for: cell) else { return }
        if let cell = cell as? ExpandableFeedItemCell {
            
            feedItems[indexPath.row - 1].isExpanded.toggle()
            
            UIView.animate(withDuration: 0.3) {
                cell.bottomView.isHidden.toggle()
                if self.alpha == 0 {
                    cell.bottomView.alpha = 1
                    self.alpha = 1
                } else {
                    cell.bottomView.alpha = 0
                    self.alpha = 0
                }
                //cell.bottomView.isOpaque.toggle()
            }

            theDayTableView.beginUpdates()
            theDayTableView.endUpdates()

        }
    }
    
    
}

