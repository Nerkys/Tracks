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
    var feedItems: [UIDayFeedItem] = []
    var fpc: FloatingPanelController!
    var contentVC: ContentViewController!
    
    func setDay(day: Day) {
        self.day = day
        feedItems = day.feedItems.map {
            UIDayFeedItem(title: $0.title, type: $0.type, isExpanded: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fpc = FloatingPanelController()
        fpc.delegate = self
        
        fpc.surfaceView.backgroundColor = .clear
        
        contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController
        
        fpc.set(contentViewController: contentVC)
        fpc.track(scrollView: contentVC.collectionView)
        fpc.addPanel(toParent: self)
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
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return MyFloatingPanelLayout()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        fpc.addPanel(toParent: self, animated: true)
//    }
}

class ContentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let trackCollectionViewCellNib = UINib(nibName: String(describing: TrackCollectionViewCell.self), bundle: nil)
        collectionView.register(trackCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: TrackCollectionViewCell.self))
        
        mainView.layer.cornerRadius = 10.0
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        mainView.layer.shadowRadius = 3
        mainView.layer.shadowOpacity = 0.2
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "MapSummaryCollectionViewCell", for: indexPath) as! MapSummaryCollectionViewCell)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TrackCollectionViewCell.self), for: indexPath) as! TrackCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //let widthPerItem = self.collectionView.frame.width
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
}

class MapSummaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    public var initialPosition: FloatingPanelPosition {
        return .tip
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
            case .full: return 0.0 // A top inset from safe area
            case .half: return 220 // A bottom inset from the safe area
            case .tip: return 145.0 // A bottom inset from the safe area
            default: return nil // Or `case .hidden: return nil`
        }
    }
}
