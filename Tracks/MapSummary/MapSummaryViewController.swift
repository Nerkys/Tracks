//
//  MapSummaryViewController.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 10.08.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit
import Mapbox

class MapSummaryViewController: UIViewController {
    
    @IBOutlet weak var mapView: MGLMapView!
    
    var day: Day!
    var feedItems: [UIDayFeedItem] = []
    
    func setDay(day: Day) {
        self.day = day
        feedItems = day.feedItems.map {
            UIDayFeedItem(title: $0.title, type: $0.type, isExpanded: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
//        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        //mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.automaticallyAdjustsContentInset = true
        mapView.setCenter(CLLocationCoordinate2D(latitude: day.coordinates.latitude, longitude: day.coordinates.longitude), zoomLevel: 14, animated: false)
//        view.addSubview(mapView)
        

    }
}
