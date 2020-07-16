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
    var selectedIndexArray: [Int] = []
    var selectedIndex = -1
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
            let item = day.feedItems[indexPath.row - 1]
            
            switch item.type {
            case .rest:
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedFullRestCell.self), for: indexPath) as? DayFeedItemCell
                (cell as? DayFeedFullRestCell)?.lineBottomConstraint.constant = indexPath.row == day.feedItems.count ? 60 : -20
                //(cell as? DayFeedFullRestCell)?.selectionStyle = .none
                
            case .lift(let liftName):
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedLiftCell.self), for: indexPath) as? DayFeedItemCell
                (cell as? DayFeedLiftCell)?.titleLabel.text = "Подъемник \(liftName)"
                (cell as? DayFeedLiftCell)?.lineBottomConstraint.constant = indexPath.row == day.feedItems.count ? 60 : -20
                //(cell as? DayFeedLiftCell)?.selectionStyle = .none
                
            case .enterLeftResort(let title, let resortName):
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedEnterLeftResortCell.self), for: indexPath) as? DayFeedItemCell
                (cell as? DayFeedEnterLeftResortCell)?.titleLabel.text = title
                (cell as? DayFeedEnterLeftResortCell)?.resortNameLabel.text = resortName
                (cell as? DayFeedEnterLeftResortCell)?.lineBottomConstraint.constant = indexPath.row == day.feedItems.count ? 29 : -20
                //(cell as? DayFeedEnterLeftResortCell)?.selectionStyle = .none
                //(cell as? DayFeedEnterLeftResortCell)?.heightOfCell.constant = 63
                

            case .track(let difficultyImageName):
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedTrackCell.self), for: indexPath) as? DayFeedItemCell
                (cell as? DayFeedTrackCell)?.difficultyImage.image = UIImage(named: difficultyImageName)
                (cell as? DayFeedTrackCell)?.lineBottomConstraint.constant = indexPath.row == day.feedItems.count ? 60 : -20
                //(cell as? DayFeedTrackCell)?.selectionStyle = .none

            }
            
            cell.viewTopConstraint.constant = indexPath.row == 1 ? 8 : 6
            //cell.viewBottomConstraint.constant = indexPath.row == 1 ? 0 : 6
            //if indexPath.row == day.feedItems.count { cell.viewTopConstraint.constant = 12}
            //cell.viewBottomConstraint.constant = indexPath.row == day.feedItems.count - 1 ? 0 : 6
            cell.lineTopConstraint.constant = indexPath.row == 1 ? -14 : -20
            
            cell.selectionStyle = .none
            
            
            //cell.lineBottomConstraint.constant = indexPath.row == day.feedItems.count ? 29 : 0
            
            return cell
            
        }
        
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != 0 && indexPath.row != 1 && indexPath.row != day.feedItems.count {
            if selectedIndexArray.contains(indexPath.row) {
                return theDayTableView.rowHeight
            } else {
                return 55
            }
        } else {
            return theDayTableView.rowHeight

        }
//            let cell = tableView.cellForRow(at: indexPath) as! TheDayStatisticsCell
//            let height = cell.frame.height
//            return CGFloat(height)

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: false)
        let dayFeedEnterLeftResortCell = tableView.cellForRow(at: indexPath) as? DayFeedEnterLeftResortCell
        if tableView.cellForRow(at: indexPath) != dayFeedEnterLeftResortCell {
            selectedIndex = indexPath.row
            if selectedIndexArray.contains(selectedIndex) {
                selectedIndexArray.removeAll {
                    $0 == selectedIndex
                }
            } else {
                selectedIndexArray.append(selectedIndex)
            }
            
//            UIView.transition(with: tableView,
//                            duration: 0.3,
//                            options: .transitionCurlDown,
//            animations: { tableView.reloadData() })
            tableView.reloadRows(at: [indexPath], with: .fade)
            tableView.beginUpdates()
            tableView.endUpdates()
            //tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            //tableView.scrollToRow(at: indexPath, at: .none, animated:   true)
            
//            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: { () -> Void in
//                tableView.beginUpdates()
//                tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
//                tableView.endUpdates()
//            }, completion: nil)
            
                
        }
        

        //UIView.setAnimationsEnabled(false)
//        tableView.beginUpdates()
//        tableView.endUpdates()
        //tableView.reloadRows(at: [indexPath], with: .fade)
        //tableView.scrollToRow(at: indexPath, at: .none, animated: true)
//        UIView.performWithoutAnimation {
//              tableView.reloadRows(at: [indexPath], with: .none)
//        }
        //UIView.setAnimationsEnabled(true)

        
        
//        UIView.animate(withDuration: 1.5) {
//            tableView.reloadData()
//        }
        
//        let transition = CATransition()
//        transition.type = CATransitionType.push
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.fillMode = CAMediaTimingFillMode.forwards
//        transition.duration = 0.5
//        transition.subtype = CATransitionSubtype.fromTop
//        tableView.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
//        tableView.reloadData()
        
//        UIView.transition(with: tableView,
//                          duration: 0.8,
//                          options: .transitionCrossDissolve,
//        animations: { tableView.reloadData() })
        
        
           
        
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

    

