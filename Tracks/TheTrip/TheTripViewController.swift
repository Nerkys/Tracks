//
//  TheTripViewController.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 07.07.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class TheTripViewController: UIViewController {
    
    
    @IBOutlet weak var theTripCollectionView: UICollectionView!
    @IBOutlet weak var statisticsView: UIView!
    @IBOutlet weak var titleAndDateLabel: UILabel!
    @IBOutlet weak var theTripTableView: UITableView!
    @IBOutlet weak var pageControl: NewPageControl!
    @IBOutlet weak var tripImage: UIImageView!
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var trip: Trip!
    private let itemsInSection: CGFloat = 3
    private var dataSourceForColletionView = [Statistics]()
    //weak var delegate: TheTripViewController?
    var imageViewRect: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dataSourceForColletionView = trip.statistics
        
        theTripTableView.delegate = self
        theTripTableView.dataSource = self
        
        theTripCollectionView.delegate = self
        theTripCollectionView.dataSource = self
        
        theTripTableView.rowHeight = UITableView.automaticDimension
        theTripTableView.tableFooterView = UIView(frame: .zero)
        
        titleAndDateLabel.text = trip.title
        
        //statisticsView.layer.cornerRadius = 10.0
        statisticsView.clipsToBounds = true
        //statisticsView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        

        let emptyTheTripCollectionViewCell = UINib(nibName: String(describing: EmptyTheTripCollectionViewCell.self), bundle: nil)
        theTripCollectionView.register(emptyTheTripCollectionViewCell, forCellWithReuseIdentifier: String(describing: EmptyTheTripCollectionViewCell.self))
        
        setImageForCollectionView(numberOfImages: trip.image.count)
        
        self.hideNavigationBar()
    }
    
    func prepareImage(paramImage: UIImage, paramFrame: CGRect) -> UIImageView {
        let result = UIImageView(frame: paramFrame)
        
        let coverLayer = CALayer()
        coverLayer.frame = result.bounds
        coverLayer.backgroundColor = UIColor.black.cgColor
        coverLayer.opacity = 0.15
        
        result.contentMode = .scaleAspectFill
        result.image = paramImage
        result.layer.addSublayer(coverLayer)
        
        return result
    }
    
    func setImageForCollectionView(numberOfImages: Int) {
        theTripCollectionView.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(numberOfImages), height: statisticsView.frame.size.height)
        imageViewRect = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: statisticsView.frame.size.height)
        theTripCollectionView.addSubview(prepareImage(paramImage: UIImage(named: trip.image[0])!, paramFrame: imageViewRect!))
 
        if trip.image.count == 1 {
            pageControl.numberOfPages = 2
            imageViewRect!.origin.x += imageViewRect!.size.width
            theTripCollectionView.addSubview(prepareImage(paramImage: UIImage(named: trip.image[0])!, paramFrame: imageViewRect!))
        } else {
            pageControl.numberOfPages = trip.image.count
            for i in 1..<numberOfImages {
                imageViewRect!.origin.x += imageViewRect!.size.width
                theTripCollectionView.addSubview(prepareImage(paramImage: UIImage(named: trip.image[i])!, paramFrame: imageViewRect!))
            }
        }
        theTripCollectionView.subviews.forEach {
            $0.layer.zPosition = -1
        }
    }
    
    func getNumberOfActiveDays(indexPath: IndexPath) -> Int {
        var count = 0
        for currentResort in 0..<trip.resorts.count {
            count += trip.resorts[currentResort].days.count
        }
        return count
    }
}

extension TheTripViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return trip.resorts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return trip.resorts[section].days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ResortsDayCell", for: indexPath) as! ResortsDayCell
        let day = trip.resorts[indexPath.section].days[indexPath.row]
        
        //cell.titleLabel.text = dateForTripOnSeasonScreen(startedAt: trip.startedAt, finishedAt: trip.finishedAt)
        cell.titleLabel.text = dateForDay(date: day.date)
        cell.maxSpeedLabel.text = "\(String(day.maxSpeed)) км/ч"
        cell.distanceLabel.text = "\(String(Double(day.distance) / 1000)) км"
        cell.numberOfTracksLabel.text = String(day.numberOfTracks)
        cell.selectionStyle = .none
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if trip.resorts.count == 1 {
            return nil
        } else {
            let header = tableView.dequeueReusableCell(withIdentifier: "TheResortHeaderCell") as! TheResortHeaderCell

            header.titleLabel.text = trip.resorts[section].title

            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if trip.resorts.count == 1 {
            return 0
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Removes extra padding in Grouped style
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard let selectedTripCell = tableView.cellForRow(at: indexPath) as? TripCell else { return }
        
        let selectedDay = trip.resorts[indexPath.section].days[indexPath.row]
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) { [ weak self ] in
//            guard let self = self else { return }
            
            let theDayViewController = self.storyboard?.instantiateViewController(withIdentifier: "TheDayViewController") as! TheDayViewController
            
            theDayViewController.setDay(day: selectedDay)
            //theTripViewController.delegate = self
            
            self.navigationController?.pushViewController(theDayViewController, animated: true)
            
        //}
        
        
    }
    
}

extension TheTripViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //return dataSourceForColletionView.count / Int(itemsInSection)
        if trip.image.count == 1 {
            return 2
        } else {
            return trip.image.count
        }
    }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return Int(itemsInSection)
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if indexPath.section <= 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TheTripCollectionViewCell", for: indexPath) as! TheTripCollectionViewCell
                let statistics = dataSourceForColletionView[indexPath.item + ((indexPath.section) * Int(itemsInSection))]
                cell.titleLabel.text = statistics.title
                cell.actionImage.image = UIImage(named: statistics.image)
                
                switch statistics.title {
                case "активные дни":
                    cell.valueLabel?.text = "\(getNumberOfActiveDays(indexPath: indexPath)) / \(getNumberOfDaysForTripOnSeasonScreen(startedAt: trip.startedAt, finishedAt: trip.finishedAt))"
                case "расстояние":
                    cell.valueLabel?.text = "\(Double(statistics.value) / 1000) км"
                case "на горе":
                    cell.valueLabel?.text = "\(statistics.value) мин"
                case "время спуска":
                    cell.valueLabel?.text = "\(statistics.value) мин"
                case "макс. скорость":
                    cell.valueLabel?.text = "\(String(statistics.value)) км/ч"
                default:
                    cell.valueLabel?.text = String(statistics.value)
                }
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyTheTripCollectionViewCell", for: indexPath) as! EmptyTheTripCollectionViewCell
                return cell
            }
            
            
        }
        
//        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//            //let x = targetContentOffset.pointee.x
//
//            pageControl.currentPage = Int(ceil(theTripCollectionView.contentOffset.x / theTripCollectionView.frame.width))
//
//
//            // on each dot, call the transform of scale 1 to restore the scale of previously selected dot
//            pageControl.subviews.forEach {
//                $0.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//            }
//            pageControl.subviews[1].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//
//            // transform the scale of the current subview dot, adjust the scale as required, but bigger the scale value, the downward the dots goes from its centre.
//            // You can adjust the centre anchor of the selected dot to keep it in place approximately.
//
//            //let centreBeforeScaling = self.pageControl.subviews[self.pageControl.currentPage].center
//
//            self.pageControl.subviews[self.pageControl.currentPage].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//
//            // Reposition using autolayout
//
//            //self.pageControl.subviews[self.pageControl.currentPage].translatesAutoresizingMaskIntoConstraints = false
//
//            //self.pageControl.subviews[self.pageControl.currentPage].centerYAnchor.constraint(equalTo: self.pageControl.subviews[0].centerYAnchor , constant: 0)
//
//            //self.pageControl.subviews[self.pageControl.currentPage].centerXAnchor.constraint(equalTo: self.pageControl.subviews[0].centerXAnchor , constant: 0)
//
//
//        //    self.pageControl.subviews[self.pageControl.currentPage].layer.anchorPoint = centreBeforeScaling
//
//        }
    
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            pageControl?.currentPage = Int(ceil(theTripCollectionView.contentOffset.x / theTripCollectionView.frame.width))
            
            if pageControl?.currentPage == 0 {
                titleAndDateLabel.text = trip.title
            } else {
                titleAndDateLabel.text = dateForTripOnSeasonScreen(startedAt: trip.startedAt, finishedAt: trip.finishedAt)
            }
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let widthPerItem = theTripCollectionView.frame.width / itemsInSection
            
            return CGSize(width: widthPerItem, height: theTripCollectionView.frame.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        
}
