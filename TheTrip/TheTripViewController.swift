//
//  TheTripViewController.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 07.07.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class TheTripViewController: UIViewController {
    
    
    
    @IBOutlet weak var theTripTableView: UITableView!
    
    var trip: Trip!
    weak var delegate: TheTripViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if #available(iOS 13.0, *) {
//            self.overrideUserInterfaceStyle = .light
//        }
        
        theTripTableView.delegate = self
        theTripTableView.dataSource = self
        
        theTripTableView.rowHeight = UITableView.automaticDimension
        
        self.hideNavigationBar()
    }
}

extension TheTripViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TheTripCell", for: indexPath) as! TheTripCell
//            return cell
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheTripCell", for: indexPath) as! TheTripCell
        cell.tripImage.image = UIImage(named: trip.image)
        
        return cell
    }
}

