//
//  ViewController.swift
//  tracks
//
//  Created by Mikhail Chukhvantsev on 23.06.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var seasonTableView: UITableView!
    
    var dataSource = [Season]()
    //let headerID = String(describing: SeasonHeaderView.self)
    var transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = getDataSourceInitialValue()
        
        seasonTableView.rowHeight = UITableView.automaticDimension
        seasonTableView.tableFooterView = UIView(frame: .zero)
        //seasonTableView.reloadData()
        
        //tableViewConfig()
        navigationController?.delegate = self
        
        self.hideNavigationBar()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let toViewController = segue.destination as UIViewController
//
//        toViewController.transitioningDelegate = self.transitionManager
//    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionManager.popStyle = (operation == .pop)
        return transitionManager
    }
    
    func getNumberOfActiveDays(tableView: UITableView, indexPath: IndexPath) -> Int {
        let trip = dataSource[indexPath.section].trip[indexPath.row]
        var count = 0
        for currentResort in 0..<trip.resorts.count {
            count += trip.resorts[currentResort].days.count
        }
        return count
    }
    
//    private func tableViewConfig() {
//        let nib = UINib(nibName: headerID, bundle: nil)
//        seasonTableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
//
//        seasonTableView.tableFooterView = UIView()
//
//    }
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].trip.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticsCell", for: indexPath) as! StatisticsCell
//
//            cell.configure(with: dataSource[indexPath.section].statistics)
//            cell.selectionStyle = .none
//
//            return cell
//
//        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripCell
        let trip = dataSource[indexPath.section].trip[indexPath.row]
        
        cell.titleLabel?.text = trip.title
        cell.tripImage?.image = UIImage(named: trip.image)
//        cell.numberOfActiveDaysLabel?.text = String(dataSource[indexPath.section].trip[indexPath.row].resorts[indexPath.row].days.count)
        cell.numberOfActiveDaysLabel?.text = "\(getNumberOfActiveDays(tableView: tableView, indexPath: indexPath))/\(getNumberOfDaysForTripOnSeasonScreen(startedAt: trip.startedAt, finishedAt: trip.finishedAt))"
        cell.numberOfTracksLabel?.text = String(trip.numberOfTracks)
        cell.distanceLabel?.text = "\(String(Double(trip.distance) / 1000))  км"
        cell.dateLabel?.text = dateForTripOnSeasonScreen(startedAt: trip.startedAt, finishedAt: trip.finishedAt)
        cell.selectionStyle = .none
        
        return cell
//        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "SeasonHeaderCell") as! SeasonHeaderCell
        
        header.titleLabel.text = dataSource[section].title

        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard let selectedTripCell = tableView.cellForRow(at: indexPath) as? TripCell else { return }
        
        //if tableView.cellForRow(at: indexPath) != tableView.cellForRow(at: indexPath) as? StatisticsCell {
            let selectedTrip = self.dataSource[indexPath.section].trip[indexPath.row]
            
            let theTripViewController = self.storyboard?.instantiateViewController(withIdentifier: "TheTripViewController") as! TheTripViewController
            
            theTripViewController.trip = selectedTrip
            //theTripViewController.delegate = self
//
            self.navigationController?.pushViewController(theTripViewController, animated: true)
            
            
        //}
    } 
    
    
}

extension UIViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}



