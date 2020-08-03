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
        return dataSource[section].trip.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticsCell", for: indexPath) as! StatisticsCell
            
            cell.configure(with: dataSource[indexPath.section].statistics)
            cell.selectionStyle = .none
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripCell
            let trip = dataSource[indexPath.section].trip[indexPath.row - 1]
            
            cell.titleLabel?.text = trip.title
            cell.tripImage?.image = UIImage(named: trip.image)
            cell.numberOfActiveDaysLabel?.text = String(trip.numberOfActiveDays)
            cell.numberOfTracksLabel?.text = String(trip.numberOfTracks)
            cell.distanceLabel?.text = "\(String(trip.distance)) м"
            cell.selectionStyle = .none
            
            return cell
        }
        
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
        
        if tableView.cellForRow(at: indexPath) != tableView.cellForRow(at: indexPath) as? StatisticsCell {
            let selectedTrip = self.dataSource[indexPath.section].trip[indexPath.row - 1]
            
            let theTripViewController = self.storyboard?.instantiateViewController(withIdentifier: "TheTripViewController") as! TheTripViewController
            //theTripViewController.transitioningDelegate = transitionManager
            theTripViewController.trip = selectedTrip
            //theTripViewController.delegate = self
//            UIView.animate(withDuration: 2.0) {() -> Void in
//                UIView.setAnimationCurve(.easeInOut)
//                self.navigationController?.pushViewController(theTripViewController, animated: true)
//                //UIView.transition(with: (self.navigationController?.view)!, duration: 2, options: .beginFromCurrentState, animations: (() -> Void)?, completion: )
//                UIView.setAnimationTransition(.flipFromLeft, for: (self.navigationController?.view)!, cache: false)
//
//            }
            
//            let container = self.navigationController?.transitionCoordinator?.containerView
//            let fromView = self.navigationController?.transitionCoordinator?.view(forKey: UITransitionContextViewKey.from)
//            let toView = self.navigationController?.transitionCoordinator?.view(forKey: UITransitionContextViewKey.to)
//
//            let offScreenRight = CGAffineTransform.init(scaleX: (container?.frame.width)!, y: 0)
//            //let offScreenLeft = CGAffineTransform.init(scaleX: -(container?.frame.width)!, y: 0)
//
//            container!.addSubview(toView!)
//            container!.addSubview(fromView!)
//
//            UIView.animate(withDuration: 3.0, delay: 0.0, usingSpringWithDamping: 0.49, initialSpringVelocity: 0.81, options: [], animations: { () -> Void in
//
//                fromView!.transform = offScreenRight
//
//                toView!.transform = CGAffineTransform.identity
//
//            })
            
            
            
            
//            let transition = CATransition()
//            transition.duration = 5
//            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//            transition.type = CATransitionType.push
//            transition.subtype = CATransitionSubtype.fromRight
//            //self.view.window?.backgroundColor = .clear
//            //transition.fillMode = CAMediaTimingFillMode.forwards
//            //view.window!.layer.add(transition, forKey: kCATransition)
//            self.navigationController?.view.layer.add(transition, forKey: nil)
            //self.navigationController?.transitioningDelegate = transitionManager
            self.navigationController?.pushViewController(theTripViewController, animated: true)
            
            
        }
    }
    

    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            tableView.deselectRow(at: indexPath, animated: false)
//        }
//    }
    

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return CGFloat(120)
//        } else 
//        
//    }
//    
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



