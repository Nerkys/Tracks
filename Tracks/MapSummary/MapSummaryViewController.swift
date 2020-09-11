//
//  MapSummaryViewController.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 10.08.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit
import Mapbox
import FloatingPanel

class MapSummaryViewController: UIViewController, FloatingPanelControllerDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mapView: MGLMapView!
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var day: Day!
    var feedItems: [DayFeedItem] = []
    var fpc: FloatingPanelController!
    var contentVC: ContentViewController!
    var newFeedItems: [UIMapSummaryStatisticsItem] = []
    var indexPathForChoosenItem: Int?
    
    func setDay(day: Day) {
        self.day = day
        feedItems = day.feedItems
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fpc = FloatingPanelController()
        fpc.delegate = self
        
        fpc.surfaceView.backgroundColor = .clear
        fpc.surfaceView.grabberHandle.isHidden = true
        //fpc.isRemovalInteractionEnabled = false
        
        contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController
        contentVC.mapSummaryVC = self
        contentVC.setDay(day: day)
        
        
        fpc.set(contentViewController: contentVC)
        fpc.track(scrollView: contentVC.scrollView)
        fpc.addPanel(toParent: self)
        //fpc.panGestureRecognizer.isEnabled = false
        //fpc.contentMode = .fitToBounds
//        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
//        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        //mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //mapView.automaticallyAdjustsContentInset = true
        mapView.setCenter(CLLocationCoordinate2D(latitude: day.coordinates.latitude, longitude: day.coordinates.longitude), zoomLevel: 14, animated: false)
//        view.addSubview(mapView)
        topView.layer.cornerRadius = 10.0
        topView.layer.shadowOffset = CGSize(width: 0, height: 0)
        topView.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        topView.layer.shadowRadius = 3
        topView.layer.shadowOpacity = 0.2
        //topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(false)
//        fpc = FloatingPanelController()
//        fpc.delegate = self
//
//        fpc.surfaceView.backgroundColor = .clear
//        fpc.surfaceView.grabberHandle.isHidden = true
//
//        fpc.set(contentViewController: contentVC)
//        fpc.track(scrollView: contentVC.scrollView)
//        fpc.addPanel(toParent: self)
//    }

    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return MyFloatingPanelLayout()
    }
    
//    func floatingPanel(_ vc: FloatingPanelController, behaviorFor newCollection: UITraitCollection) -> FloatingPanelBehavior? {
//        return MyFloatingPanelBehavior()
//    }
    
}

class ContentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FloatingPanelControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewUnderScrollView: UIView!
    var initialPosition: FloatingPanelPosition {
        return .tip
    }
    var mapSummaryVC: MapSummaryViewController!
    var day: Day!
    var feedItems: [DayFeedItem] = []
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 4.0, bottom: 0.0, right: 4.0)
    private let itemsPerRow: CGFloat = 1
    
    func setDay(day: Day) {
        self.day = day
        feedItems = day.feedItems
        feedItems = feedItems.filter() {
            switch $0.type {
            case .enterLeftResort:
                return false
            default:
                return true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
//        mapSummaryVC = storyboard?.instantiateViewController(withIdentifier: "MapSummaryViewController") as? MapSummaryViewController
        //mapSummaryVC.fpc.panGestureRecognizer.isEnabled = false
        
        //scrollView.bounds.height = view.bounds.height
        
        let dayStatisticsCollectionViewCellNib = UINib(nibName: String(describing: DayStatisticsCollectionViewCell.self), bundle: nil)
        collectionView.register(dayStatisticsCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: DayStatisticsCollectionViewCell.self))
        let restCollectionViewCellNib = UINib(nibName: String(describing: RestCollectionViewCell.self), bundle: nil)
        collectionView.register(restCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: RestCollectionViewCell.self))
        let liftCollectionViewCellNib = UINib(nibName: String(describing: LiftCollectionViewCell.self), bundle: nil)
        collectionView.register(liftCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: LiftCollectionViewCell.self))
        let trackCollectionViewCellNib = UINib(nibName: String(describing: TrackCollectionViewCell.self), bundle: nil)
        collectionView.register(trackCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: TrackCollectionViewCell.self))
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [ unowned self ] in
            if self.mapSummaryVC.indexPathForChoosenItem != nil {
                self.collectionView.setContentOffset(CGPoint(x: self.collectionView.frame.width * CGFloat(self.mapSummaryVC.indexPathForChoosenItem!), y: 0), animated: false)
            }
        })
        
        //scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - 500)
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        //print(view.frame.width / 2)
//        print(scrollView.contentOffset.x)
//        if scrollView.contentOffset.x >= view.frame.width / 2 {
//
//            print("dfdknfwefewfjekfkenfknekwfnw \(scrollView.contentOffset.x)")
//
//        }
//        //print(scrollView.contentOffset.x)
//    }

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = (collectionView.indexPathForItem(at: visiblePoint))!
        let cell = collectionView.cellForItem(at: visibleIndexPath)
        self.mapSummaryVC.fpc.move(to: .tip, animated: true)

        if cell is LiftCollectionViewCell || cell is RestCollectionViewCell {
            mapSummaryVC.fpc.panGestureRecognizer.isEnabled = false
        } else {
            mapSummaryVC.fpc.panGestureRecognizer.isEnabled = true
        }
    }
    

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        feedItems.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DayStatisticsCollectionViewCell.self), for: indexPath) as! DayStatisticsCollectionViewCell
            return cell
        } else {
            var cell: MapSummaryStatiscticsItemCell!
            let item = feedItems[indexPath.section - 1]
            
            switch item.type {
            case .rest:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RestCollectionViewCell.self), for: indexPath) as? MapSummaryStatiscticsItemCell
                (cell as? RestCollectionViewCell)?.titleLabel.text = "Отдых (\(indexPath.section)/\(feedItems.count))"
                  
            case .lift(let liftName):
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LiftCollectionViewCell.self), for: indexPath) as? MapSummaryStatiscticsItemCell
                (cell as? LiftCollectionViewCell)?.titleLabel.text = "\(liftName) (\(indexPath.section)/\(feedItems.count))"
                
            case .track(let difficultyImageName):
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TrackCollectionViewCell.self), for: indexPath) as? MapSummaryStatiscticsItemCell
                (cell as? TrackCollectionViewCell)?.titleLabel.text = "Роза Блейд (\(indexPath.section)/\(feedItems.count))"
                (cell as? TrackCollectionViewCell)?.difficultyImage.image = UIImage(named: difficultyImageName)
            case .enterLeftResort:
                break
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = self.collectionView.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        //return CGSize(width: widthPerItem, height: self.collectionView.frame.height)
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20.0
//    }
    
}


class MyFloatingPanelLayout: FloatingPanelLayout {
    public var initialPosition: FloatingPanelPosition {
        return .tip
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 0.0 // A top inset from safe area
        case .half: return 220.0 // A bottom inset from the safe area
        case .tip: return 145.0 // A bottom inset from the safe area
        default: return nil // Or `case .hidden: return nil`
        }
    }
}

//class MyFloatingPanelBehavior: FloatingPanelBehavior {
//
//    func shouldProjectMomentum(_ fpc: FloatingPanelController, for proposedTargetPosition: FloatingPanelPosition) -> Bool {
//        return false
//    }
//}

//extension UIScrollView {
//    func scrollToTop(animated: Bool) {
//        setContentOffset(CGPoint(x: 0, y: -contentInset.top),
//                         animated: animated)
//    }
//
//    func scrollToBottom(animated: Bool) {
//        setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude),
//                     animated: animated)
//    }
//}
