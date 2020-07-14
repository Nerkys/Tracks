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
    //weak var delegate: TheDayViewController?
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        theDayTableView.delegate = self
        theDayTableView.dataSource = self
        theDayTableView.tableFooterView = UIView(frame: .zero)
        theDayTableView.rowHeight = UITableView.automaticDimension
        
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
            let item = day.feedItems[indexPath.row - 1]
            
            switch item.type {
            case .rest:
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedFullRestCell.self), for: indexPath) as? DayFeedItemCell
                (cell as? DayFeedFullRestCell)?.lineBottomConstraint.constant = indexPath.row == day.feedItems.count ? 55 : 0
            case .lift(let liftName):
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedLiftCell.self), for: indexPath) as? DayFeedItemCell
                (cell as? DayFeedLiftCell)?.titleLabel.text = "Подъемник \(liftName)"
                (cell as? DayFeedLiftCell)?.lineBottomConstraint.constant = indexPath.row == day.feedItems.count ? 45 : 0
            case .enterLeftResort(let title, let resortName):
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedEnterLeftResortCell.self), for: indexPath) as? DayFeedItemCell
                (cell as? DayFeedEnterLeftResortCell)?.titleLabel.text = title
                (cell as? DayFeedEnterLeftResortCell)?.resortNameLabel.text = resortName
                (cell as? DayFeedEnterLeftResortCell)?.lineBottomConstraint.constant = indexPath.row == day.feedItems.count ? 29 : 0

            case .track(let difficultyImageName):
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedTrackCell.self), for: indexPath) as? DayFeedItemCell
                (cell as? DayFeedTrackCell)?.difficultyImage.image = UIImage(named: difficultyImageName)
                (cell as? DayFeedTrackCell)?.lineBottomConstraint.constant = indexPath.row == day.feedItems.count ? 40 : 0

            }
            
            cell.viewTopConstraint.constant = indexPath.row == 1 ? 14 : 6
            if indexPath.row == day.feedItems.count { cell.viewTopConstraint.constant = 12}
            cell.viewBottomConstraint.constant = indexPath.row == day.feedItems.count - 1 ? 0 : 6
            
            cell.lineTopConstraint.constant = indexPath.row == 1 ? -14 : -12
            //cell.lineBottomConstraint.constant = indexPath.row == day.feedItems.count ? 29 : 0
            
            return cell
            
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row != 0 {
//            if selectedIndex == indexPath { return 200 }
//            return 76
//        } else {
//            return 125
//
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.beginUpdates()
//        tableView.reloadRows(at: [selectedIndex], with: .none)
//        tableView.endUpdates()
//    }
}

    

