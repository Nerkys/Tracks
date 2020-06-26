//
//  ViewController.swift
//  tracks
//
//  Created by Mikhail Chukhvantsev on 23.06.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var seasonTableView: UITableView!
    
    private var dataSource = [Season]()
    
    
    let headerID = String(describing: SeasonHeaderView.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        dataSource = getDataSourceInitialValue()
        
        seasonTableView.rowHeight = UITableView.automaticDimension
        //seasonTableView.tableFooterView = UIView(frame: .zero)
        //seasonTableView.reloadData()
        
        tableViewConfig()
        
        self.hideNavigationBar()
    }
    
    private func tableViewConfig() {
        let nib = UINib(nibName: headerID, bundle: nil)
        seasonTableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
        
        seasonTableView.tableFooterView = UIView()
        
    }
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].trip.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticsCell", for: indexPath) as! StatisticsCell
            let maxSpeed = String(dataSource[indexPath.section].maxSpeed)
            let distance = String(dataSource[indexPath.section].distance)
            let numberOfTracks = String(dataSource[indexPath.section].numberOfTracks)
            
            cell.maxSpeedLabel?.text = maxSpeed
            cell.distanceLabel?.text = distance
            cell.numberOfTracksLabel?.text = numberOfTracks
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripCell
            let trip = dataSource[indexPath.section].trip[indexPath.row - 1]
            let tripImage = UIImage(named: trip.image)
            
            cell.titleLabel?.text = trip.title
            cell.tripImage?.image = tripImage
            cell.tripImage?.contentMode = .scaleAspectFill
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as! SeasonHeaderView
        
      header.titleLabel.text = dataSource[section].title

        return header
    }
    

    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        300
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 60
//    }
    
    
}

extension UIViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
