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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var theDayCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var statisticsView: UIView!
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var day: Day!
    var feedItems: [UIDayFeedItem] = []

    private let itemsInSection: CGFloat = 3
    private var dataSourceForColletionView = [Statistics]()
    

    //weak var delegate: TheDayViewController?

    
    func setDay(day: Day) {
        self.day = day
        feedItems = day.feedItems.map {
            UIDayFeedItem(title: $0.title, type: $0.type, isExpanded: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSourceForColletionView = day.statistics
        dateLabel?.text = day.date
        
        theDayTableView.delegate = self
        theDayTableView.dataSource = self
        theDayTableView.tableFooterView = UIView(frame: .zero)
        
        theDayCollectionView.delegate = self
        theDayCollectionView.dataSource = self
        //theDayTableView.rowHeight = UITableView.automaticDimension
        //theDayTableView.estimatedRowHeight = 90
        
        theDayTableView.separatorStyle = .none
        
        statisticsView.layer.cornerRadius = 10.0
        statisticsView.layer.shadowOffset = CGSize(width: 0, height: 0)
        statisticsView.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        statisticsView.layer.shadowRadius = 3
        statisticsView.layer.shadowOpacity = 0.2
        //view.clipsToBounds = false

        //layer.zPosition = 1
            
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
        return day.feedItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            var cell: DayFeedItemCell!
            let item = feedItems[indexPath.row]
            
            switch item.type {
            case .rest:
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedFullRestCell.self), for: indexPath) as? DayFeedItemCell
                (cell as? DayFeedFullRestCell)?.bottomView.isHidden = !item.isExpanded
                (cell as? DayFeedFullRestCell)?.lineTopConstraint.constant = indexPath.row == 1 ? -6 : -20
                (cell as? DayFeedFullRestCell)?.delegate = self
                

            case .lift(let liftName):
                cell = ((tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedLiftCell.self), for: indexPath) as? DayFeedLiftCell)!)
                (cell as? DayFeedLiftCell)?.buttonTitleLabel.setTitle("Подъемник \(liftName)", for: .normal)
                (cell as? DayFeedLiftCell)?.bottomView.isHidden = !item.isExpanded
                (cell as? DayFeedLiftCell)?.lineTopConstraint.constant = indexPath.row == 1 ? -6 : -20
                (cell as? DayFeedLiftCell)?.delegate = self

            case .enterLeftResort(let title, let resortName):
                cell = (tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedEnterLeftResortCell.self), for: indexPath) as? DayFeedItemCell)!
                (cell as? DayFeedEnterLeftResortCell)?.titleLabel.text = title
                (cell as? DayFeedEnterLeftResortCell)?.resortNameLabel.text = resortName
                (cell as? DayFeedEnterLeftResortCell)?.lineBottomConstraint.constant = indexPath.row == feedItems.count - 1 ? 30 : -20
                (cell as? DayFeedEnterLeftResortCell)?.lineTopConstraint.constant = indexPath.row == 1 ? -6 : -20

            case .track(let difficultyImageName):
                cell = (tableView.dequeueReusableCell(withIdentifier: String(describing: DayFeedTrackCell.self), for: indexPath) as? DayFeedItemCell)!
                (cell as? DayFeedTrackCell)?.difficultyImage.image = UIImage(named: difficultyImageName)
                (cell as? DayFeedTrackCell)?.lineTopConstraint.constant = indexPath.row == 1 ? -6 : -20
            }
            
            return cell
        
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
        if var cell = cell as? ExpandableFeedItemCell {
            
            feedItems[indexPath.row].isExpanded.toggle()
            
            UIView.animate(withDuration: 0.3) {
                cell.bottomView.isHidden.toggle()
                if cell.viewAlpha == 0 {
                    cell.bottomView.alpha = 1
                    cell.viewAlpha = 1
                } else {
                    cell.bottomView.alpha = 0
                    cell.viewAlpha = 0
                }
            }

            theDayTableView.beginUpdates()
            theDayTableView.endUpdates()

        }
    }
    
    
}

extension TheDayViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSourceForColletionView.count / Int(itemsInSection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(itemsInSection)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TheDayCollectionViewCell", for: indexPath) as! TheDayCollectionViewCell
        let statistics = dataSourceForColletionView[indexPath.item + ((indexPath.section) * Int(itemsInSection))]
        
        cell.titleLabel?.text = statistics.title
        cell.actionImage?.image = UIImage(named: statistics.image)
        
        switch statistics.title {
        case "макс. скорость":
            cell.valueLabel?.text = "\(String(statistics.value)) км/ч"
        case "расстояние":
            cell.valueLabel?.text = "\(String(statistics.value)) м"
        case "на горе":
            cell.valueLabel?.text = "\(String(statistics.value)) мин"
        case "время спуска":
            cell.valueLabel?.text = "\(String(statistics.value)) мин"
        default:
            cell.valueLabel?.text = String(statistics.value)
        }
        return cell
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(ceil(theDayCollectionView.contentOffset.x / theDayCollectionView.frame.width))
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthPerItem = theDayCollectionView.frame.width / itemsInSection
        return CGSize(width: widthPerItem, height: theDayCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
