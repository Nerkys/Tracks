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
    
    func setDay(day: Day) {
        self.day = day
        feedItems = day.feedItems.map {
            UIDayFeedItem(title: $0.title, type: $0.type, isExpanded: false)
        }
    }
    
    var selectedIndexArray: [Int] = []
    var selectedIndex = -1
    //weak var delegate: TheDayViewController?
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
//    var expandedCells: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theDayTableView.delegate = self
        theDayTableView.dataSource = self
        theDayTableView.tableFooterView = UIView(frame: .zero)
        theDayTableView.rowHeight = UITableView.automaticDimension
        theDayTableView.estimatedRowHeight = 90
        
        theDayTableView.separatorStyle = .none
        
//        day.feedItems.forEach() {_ in
//            expandedCells.append(false)
//        }
        
            
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
                (cell as? DayFeedFullRestCell)?.lineBottomConstraint.constant = indexPath.row == feedItems.count ? 60 : 0
                (cell as? DayFeedFullRestCell)?.bottomView.isHidden = !item.isExpanded

            case .lift(let liftName):
                cell = ((tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedLiftCell.self), for: indexPath) as? DayFeedLiftCell)!)
                (cell as? DayFeedLiftCell)?.titleLabel.text = "Подъемник \(liftName)"
                (cell as? DayFeedLiftCell)?.lineBottomConstraint.constant = indexPath.row == feedItems.count ? 60 : 0
                (cell as? DayFeedLiftCell)?.bottomView.isHidden = !item.isExpanded

            case .enterLeftResort(let title, let resortName):
                cell = (tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedEnterLeftResortCell.self), for: indexPath) as? DayFeedItemCell)!
                (cell as? DayFeedEnterLeftResortCell)?.titleLabel.text = title
                (cell as? DayFeedEnterLeftResortCell)?.resortNameLabel.text = resortName
                (cell as? DayFeedEnterLeftResortCell)?.lineBottomConstraint.constant = indexPath.row == feedItems.count ? 30 : 0

            case .track(let difficultyImageName):
                cell = (tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedTrackCell.self), for: indexPath) as? DayFeedItemCell)!
                (cell as? DayFeedTrackCell)?.difficultyImage.image = UIImage(named: difficultyImageName)
                (cell as? DayFeedTrackCell)?.lineBottomConstraint.constant = indexPath.row == feedItems.count ? 60 : 0
            }
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath) as? ExpandableFeedItemCell {
            
            feedItems[indexPath.row - 1].isExpanded.toggle()
            
            UIView.animate(withDuration: 0.3) {
                cell.bottomView.isHidden.toggle()
            }

            tableView.beginUpdates()
            tableView.endUpdates()

        }
    }

    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row != 0 && indexPath.row != 1 && indexPath.row != day.feedItems.count {
//            if selectedIndexArray.contains(indexPath.row) {
//                return theDayTableView.rowHeight
//            } else {
//                return 55
//            }
//        } else {
//            return theDayTableView.rowHeight
//
//        }
////            let cell = tableView.cellForRow(at: indexPath) as! TheDayStatisticsCell
////            let height = cell.frame.height
////            return CGFloat(height)
//
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //tableView.deselectRow(at: indexPath, animated: false)
//        let dayFeedEnterLeftResortCell = tableView.cellForRow(at: indexPath) as? DayFeedEnterLeftResortCell
//        if tableView.cellForRow(at: indexPath) != dayFeedEnterLeftResortCell {
//            selectedIndex = indexPath.row
//            if selectedIndexArray.contains(selectedIndex) {
//                selectedIndexArray.removeAll {
//                    $0 == selectedIndex
//                }
//            } else {
//                selectedIndexArray.append(selectedIndex)
//            }
//
////            UIView.transition(with: tableView,
////                            duration: 0.3,
////                            options: .transitionCurlDown,
////            animations: { tableView.reloadData() })
//            tableView.reloadRows(at: [indexPath], with: .fade)
////            tableView.beginUpdates()
////            tableView.endUpdates()
//            //tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
//            //tableView.scrollToRow(at: indexPath, at: .none, animated:   true)
//
////            UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: { () -> Void in
////                //tableView.beginUpdates()
////                tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
////                //tableView.endUpdates()
////            }, completion: nil)
//
//
//        }
//
//

//
//
//    }
    
 ////////////////////////////////////////////////

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

    

