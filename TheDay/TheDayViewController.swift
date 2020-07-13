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
    weak var delegate: TheDayViewController?
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
    //        if #available(iOS 13.0, *) {
    //            self.overrideUserInterfaceStyle = .light
    //        }
            //dataSource = getDataSourceInitialValue()
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
}

extension TheDayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //day.feedItems.count
        return day.feedItems.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = theDayTableView.dequeueReusableCell(withIdentifier: "TheDayStatisticsCell", for: indexPath) as! TheDayStatisticsCell
            
            cell.configure(with: day)
            cell.dateLabel.text = day.date
            cell.selectionStyle = .none
            cell.lineTopConstraint.constant = 0
            cell.lineBottomConstraint.constant = 0
            
            return cell
            
            
        } else {
            var cell: DayFeedItemCell!
            let item = day.feedItems[indexPath.row - 1]
            
            switch item.type {
            case .rest:
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedFullRestCell.self), for: indexPath) as? DayFeedItemCell
            case .lift(let liftName):
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedLiftCell.self), for: indexPath) as? DayFeedItemCell
                (cell as? DayFeedLiftCell)?.titleLabel.text = "Подъемник \(liftName)"
            case .enterLeftResort(let title, let resortName):
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedEnterLeftResortCell.self), for: indexPath) as? DayFeedItemCell
                (cell as? DayFeedEnterLeftResortCell)?.viewTopConstraint.constant = indexPath.row == 1 ? 12 : 6
                (cell as? DayFeedEnterLeftResortCell)?.titleLabel.text = title
                (cell as? DayFeedEnterLeftResortCell)?.resortNameLabel.text = resortName
            case .track(let difficultyImageName):
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedTrackCell.self), for: indexPath) as? DayFeedItemCell
                (cell as? DayFeedTrackCell)?.difficultyImage.image = UIImage(named: difficultyImageName)
            }
            
            cell.lineTopConstraint.constant = indexPath.row == 1 ? -12 : -12
            cell.lineBottomConstraint.constant = indexPath.row == day.feedItems.count ? 24 : 0
            
            return cell
        }
    }
}

    

