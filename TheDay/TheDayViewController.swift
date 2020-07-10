//
//  TheDayViewController.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 10.07.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class TheDayViewController: UIViewController {
    
    @IBOutlet var theDayTableView: UITableView!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
    //        if #available(iOS 13.0, *) {
    //            self.overrideUserInterfaceStyle = .light
    //        }
            //dataSource = getDataSourceInitialValue()
            theDayTableView.delegate = self
            theDayTableView.dataSource = self
            
            theDayTableView.rowHeight = UITableView.automaticDimension
            
            self.hideNavigationBar()
        }
}

extension TheDayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

    

