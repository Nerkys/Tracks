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
    
    @IBOutlet weak var mapView: MGLMapView!
    
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
        
        //fpc.surfaceView.backgroundColor = .clear
        
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
        
        
        

    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return MyFloatingPanelLayout()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        fpc.addPanel(toParent: self, animated: true)
//    }
}

class ContentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "MapSummaryCollectionViewCell", for: indexPath) as! MapSummaryCollectionViewCell)
        return cell
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
            case .half: return 250 // A bottom inset from the safe area
        case .tip: return 136.0 // A bottom inset from the safe area
            default: return nil // Or `case .hidden: return nil`
        }
    }
}
