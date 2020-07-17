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
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    var trip: Trip!
    //weak var delegate: TheTripViewController?
    //var dataSource = [Season]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if #available(iOS 13.0, *) {
//            self.overrideUserInterfaceStyle = .light
//        }
        //dataSource = getDataSourceInitialValue()
        theTripTableView.delegate = self
        theTripTableView.dataSource = self
        
        theTripTableView.rowHeight = UITableView.automaticDimension
        
        self.hideNavigationBar()
    }
}

extension TheTripViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return trip.resorts.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return trip.resorts[section - 1].days.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TheTripStatisticsCell", for: indexPath) as! TheTripStatisticsCell
            
            cell.configure(with: trip)

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResortsDayCell", for: indexPath) as! ResortsDayCell
            let day = trip.resorts[indexPath.section - 1].days[indexPath.row]
            
            cell.titleLabel.text = day.date
            cell.maxSpeedLabel.text = "\(String(day.maxSpeed)) км/ч"
            cell.distanceLabel.text = "\(String(day.distance)) м"
            cell.numberOfTracksLabel.text = String(day.numberOfTracks)
            cell.selectionStyle = .none
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if  section == 0 {
            return nil
        } else {
            let header = tableView.dequeueReusableCell(withIdentifier: "TheResortHeaderCell") as! TheResortHeaderCell

            header.titleLabel.text = trip.resorts[section - 1].title

            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard let selectedTripCell = tableView.cellForRow(at: indexPath) as? TripCell else { return }
        
        if indexPath.section != 0 {
            let selectedDay = trip.resorts[indexPath.section - 1].days[indexPath.row]
            
            let theDayViewController = self.storyboard?.instantiateViewController(withIdentifier: "TheDayViewController") as! TheDayViewController
            
            theDayViewController.day = selectedDay
            //theTripViewController.delegate = self
            
            self.navigationController?.pushViewController(theDayViewController, animated: true)
        }
    }
    
}

