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
    let tripImage = UIImage(named: "Andorra")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = getDataSourceInitialValue()
        
        tableViewConfig()
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
        return dataSource[section].resort.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonCell", for: indexPath)
        let trip = dataSource[indexPath.section].resort[indexPath.row]
        
        cell.imageView?.image = tripImage
        cell.textLabel?.text = trip.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as! SeasonHeaderView
        
        header.titleLabel.text = dataSource[section].title

        return header
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 60
//    }

    
    
    
}
